class CreatePractitionerProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :practitioner_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :profession
      t.boolean :verified

      t.timestamps
    end
  end
end
