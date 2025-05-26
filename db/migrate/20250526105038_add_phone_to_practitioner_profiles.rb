class AddPhoneToPractitionerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :practitioner_profiles, :phone, :string
  end
end
