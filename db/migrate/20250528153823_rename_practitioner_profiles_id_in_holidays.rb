class RenamePractitionerProfilesIdInHolidays < ActiveRecord::Migration[8.0]
  def change
        rename_column :holidays, :practitioner_profiles_id, :practitioner_profile_id
  end
end
