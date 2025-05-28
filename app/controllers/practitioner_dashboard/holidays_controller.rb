module PractitionerDashboard
  class HolidaysController < ApplicationController
    before_action :require_practitioner
    before_action :set_profile

    def create
      @holiday = @profile.holidays.build(holiday_params)
      if @holiday.save
        DeleteHolidaySlotsJob.perform_later(@holiday.id, @profile.id)
        redirect_to practitioner_dashboard_practitioner_availabilities_path, notice: "Holiday added."
      else
        redirect_to practitioner_dashboard_practitioner_availabilities_path, alert: "Could not add holiday: #{@holiday.errors.full_messages.to_sentence}"
      end
    end

    def destroy
      @holiday = @profile.holidays.find(params[:id])
      @holiday.destroy
      redirect_to practitioner_dashboard_practitioner_availabilities_path, notice: "Holiday deleted."
    end

    private

    def holiday_params
      params.require(:holiday).permit(:name, :start_date, :end_date)
    end

    def set_profile
      @profile = Current.user.practitioner_profile
    end

    def require_practitioner
      redirect_to root_path unless Current.user&.practitioner?
    end
  end
end
