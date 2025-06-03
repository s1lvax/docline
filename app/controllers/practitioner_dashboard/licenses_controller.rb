module PractitionerDashboard
  class LicensesController < PractitionerDashboard::DashboardController
    def show
      @profile = Current.user.practitioner_profile
    end

    def create
      profile = Current.user.practitioner_profile

      session_params = {
        payment_method_types: [ "card" ],
        mode: "subscription",
        line_items: [ {
          price: Stripe::Plans::SUBSCRIPTION, # or your plan constant
          quantity: 1
        } ],
        success_url: practitioner_dashboard_licenses_success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: practitioner_dashboard_licenses_cancel_url
      }

      # If we have a Stripe customer id, reuse it!
      if profile.stripe_customer_id.present?
        session_params[:customer] = profile.stripe_customer_id
      else
        session_params[:customer_email] = Current.user.email_address
      end

      session = Stripe::Checkout::Session.create(session_params)

      redirect_to session.url, allow_other_host: true
    end

    def success
      session = Stripe::Checkout::Session.retrieve(params[:session_id])

      # Retrieve subscription and customer details
      stripe_subscription_id = session.subscription
      stripe_customer_id     = session.customer

      # Get the latest subscription status from Stripe
      subscription = Stripe::Subscription.retrieve(stripe_subscription_id)

      # Save to current user's practitioner profile
      profile = Current.user.practitioner_profile
      profile.update!(
        subscription_status: subscription.status,
        stripe_customer_id: stripe_customer_id,
        stripe_subscription_id: stripe_subscription_id
      )

      if profile.subscription_status == "active"
        MakeSlotsVisibleJob.perform_later(profile.id)
      end

      flash[:notice] = "Your license purchase was successful. Your availabilities are now bookable!"
      redirect_to practitioner_dashboard_profile_path
    end

    def cancel
      flash[:alert] = "Your license purchase was canceled"
      redirect_to practitioner_dashboard_profile_path
    end

    def cancel_subscription
      profile = Current.user.practitioner_profile

      if profile.stripe_subscription_id.present?
        Stripe::Subscription.update(
          profile.stripe_subscription_id,
          cancel_at_period_end: true # Or use :cancel_now if you want immediate
        )
        profile.update!(subscription_status: "canceled")
        SendSubscriptionCanceledJob.perform_later(profile.id)
        flash[:notice] = "Your subscription will be canceled at the end of the current period."
      else
        flash[:alert] = "No active subscription found."
      end

      redirect_to practitioner_dashboard_profile_path
    end
  end
end
