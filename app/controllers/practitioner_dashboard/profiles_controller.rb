module PractitionerDashboard
  class ProfilesController < PractitionerDashboard::DashboardController
    # GET /practitioner_dashboard/practitioner_profile
    def show
      if @profile.stripe_customer_id.present?
        @invoices = Stripe::Invoice.list(customer: @profile.stripe_customer_id, limit: 4).data.map do |inv|
          {
            label: inv.lines.data&.first&.description || "Invoice",
            date: inv.created ? Time.at(inv.created).to_date : nil,
            pdf_url: inv.invoice_pdf
          }
        end
      else
        @invoices = []
      end
    end

    # GET /practitioner_dashboard/practitioner_profile/edit
    def edit
    end

    # PATCH /practitioner_dashboard/practitioner_profile
    def update
      if @profile.update(practitioner_profile_params)
        redirect_to practitioner_dashboard_profile_path,
                    notice: "Profile was successfully updated."
      else
        # collect full messages, or use a generic error
        flash.now[:alert] = @profile.errors.full_messages.to_sentence
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def practitioner_profile_params
      params.require(:practitioner_profile)
            .permit(:name, :contact_email, :phone, :bio, :profession, :profile_picture, :address)
    end
  end
end
