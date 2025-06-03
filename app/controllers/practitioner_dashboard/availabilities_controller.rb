module PractitionerDashboard
  class AvailabilitiesController < PractitionerDashboard::DashboardController
    before_action :set_practitioner_availability, only: %i[show edit update destroy]

    # GET /practitioner_dashboard/practitioner_availabilities
    def index
      @practitioner_availabilities = @profile.practitioner_availabilities.order(:weekday, :start_time)
      # For grouped view in the weekly table
      @availabilities_by_weekday = @practitioner_availabilities.group_by(&:weekday)
    end

    # GET /practitioner_dashboard/practitioner_availabilities/1
    def show
    end

    # GET /practitioner_dashboard/practitioner_availabilities/new
    def new
      @practitioner_availability = @profile.practitioner_availabilities.build
      @practitioner_availability.weekday = params[:weekday] if params[:weekday].present?
    end

    # GET /practitioner_dashboard/practitioner_availabilities/1/edit
    def edit
    end

    # POST /practitioner_dashboard/practitioner_availabilities
    def create
      @practitioner_availability = @profile.practitioner_availabilities.build(practitioner_availability_params)

      respond_to do |format|
        if @practitioner_availability.save
          format.html { redirect_to practitioner_dashboard_availabilities_path, notice: "Availability was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /practitioner_dashboard/practitioner_availabilities/1
    def update
      respond_to do |format|
        if @practitioner_availability.update(practitioner_availability_params)
          format.html { redirect_to practitioner_dashboard_availabilities_path, notice: "Availability was successfully updated." }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /practitioner_dashboard/practitioner_availabilities/1
    def destroy
      @practitioner_availability.destroy!
      respond_to do |format|
        format.html { redirect_to practitioner_dashboard_availabilities_path, status: :see_other, notice: "Availability was successfully destroyed." }
      end
    end

    private

      def set_practitioner_availability
        @practitioner_availability = @profile.practitioner_availabilities.find(params[:id])
      end

      def practitioner_availability_params
        params.require(:practitioner_availability).permit(:weekday, :start_time, :end_time, :slot_duration_minutes, :weeks_ahead)
      end
  end
end
