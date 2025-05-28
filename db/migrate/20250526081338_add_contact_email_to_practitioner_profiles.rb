class AddContactEmailToPractitionerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column(:practitioner_profiles, :contact_email, :string)
  end
end
