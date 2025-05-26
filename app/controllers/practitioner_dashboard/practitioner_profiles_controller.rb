module PractitionerDashboard
  class PractitionerProfilesController < ApplicationController
    before_action :require_practitioner
    before_action :set_profile, only: %i[show edit update]

    # GET /practitioner_dashboard/practitioner_profile
    def show
    end

    # GET /practitioner_dashboard/practitioner_profile/edit
    def edit
    end

    # PATCH /practitioner_dashboard/practitioner_profile
    def update
      if @profile.update(practitioner_profile_params)
        redirect_to practitioner_dashboard_practitioner_profile_path,
                    notice: "Profile was successfully updated."
      else
        # collect full messages, or use a generic error
        flash.now[:alert] = @profile.errors.full_messages.to_sentence
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_profile
      @profile = Current.user.practitioner_profile ||
                 Current.user.create_practitioner_profile!
    end

    def practitioner_profile_params
      params.require(:practitioner_profile)
            .permit(:name, :contact_email, :phone, :bio, :profession, :profile_picture, :address)
    end

    def require_practitioner
      redirect_to root_path unless Current.user&.practitioner?
    end
  end
end
