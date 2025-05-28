class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  # Make sure the user is a practitioner
  def require_practitioner
    redirect_to root_path unless Current.user&.practitioner?
  end
end
