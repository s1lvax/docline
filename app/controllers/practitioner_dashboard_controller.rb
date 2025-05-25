class PractitionerDashboardController < ApplicationController
  before_action :require_practitioner

  def index
  end

  private

  def require_practitioner
    redirect_to root_path unless Current.user&.practitioner?
  end
end
