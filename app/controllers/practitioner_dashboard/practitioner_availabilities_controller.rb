module PractitionerDashboard
class PractitionerAvailabilitiesController < ApplicationController
  before_action :set_profile
  before_action :require_practitioner
  before_action :set_practitioner_availability, only: %i[show edit update destroy]

  # GET /practitioner_dashboard/practitioner_availabilities
  def index
    @practitioner_availabilities = @profile.practitioner_availabilities
  end

  # GET /practitioner_dashboard/practitioner_availabilities/1
  def show
  end

  # GET /practitioner_dashboard/practitioner_availabilities/new
  def new
    @practitioner_availability = @profile.practitioner_availabilities.build
  end

  # GET /practitioner_dashboard/practitioner_availabilities/1/edit
  def edit
  end

  # POST /practitioner_dashboard/practitioner_availabilities
  def create
    @practitioner_availability = @profile.practitioner_availabilities.build(practitioner_availability_params)

    respond_to do |format|
      if @practitioner_availability.save
        format.html { redirect_to [ :practitioner_dashboard, @practitioner_availability ], notice: "Practitioner availability was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practitioner_dashboard/practitioner_availabilities/1
  def update
    respond_to do |format|
      if @practitioner_availability.update(practitioner_availability_params)
        format.html { redirect_to [ :practitioner_dashboard, @practitioner_availability ], notice: "Practitioner availability was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practitioner_dashboard/practitioner_availabilities/1
  def destroy
    @practitioner_availability.destroy!
    respond_to do |format|
      format.html { redirect_to practitioner_dashboard_practitioner_availabilities_path, status: :see_other, notice: "Practitioner availability was successfully destroyed." }
    end
  end

  private

    def set_practitioner_availability
      @practitioner_availability = @profile.practitioner_availabilities.find(params[:id])
    end

    def set_profile
      @profile = Current.user.practitioner_profile || PractitionerProfile.new(user: Current.user)
    end

    def practitioner_availability_params
      params.require(:practitioner_availability).permit(:start_time, :end_time)
    end
end
end
