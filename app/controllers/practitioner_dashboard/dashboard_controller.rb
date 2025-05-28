module PractitionerDashboard
  class DashboardController < ApplicationController
    before_action :require_practitioner
    before_action :set_profile

    def index
    end

    private

    def set_profile
      @profile = Current.user.practitioner_profile ||
                 Current.user.create_practitioner_profile!
    end
  end
end
