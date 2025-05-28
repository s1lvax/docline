class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  def patient
  end

  def practitioner
    @user = User.new(role: :practitioner)
  end

  def create_user
    @user = User.new(user_params)

    if @user.save
      start_new_session_for(@user)
      redirect_to root_path, notice: "Registration sucessful"
    else
      render @user.practitioner? ? :practitioner : :patient
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :family_name, :email_address, :password, :role)
  end
end
