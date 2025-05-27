module PractitionerDashboard::PractitionerAvailabilitiesHelper
  def workday_time_options
    (5..23).flat_map { |h| [ 0, 30 ].map { |m| format("%02d:%02d", h, m) } }
  end
end
