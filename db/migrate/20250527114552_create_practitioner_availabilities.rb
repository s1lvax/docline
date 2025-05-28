class CreatePractitionerAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :practitioner_availabilities do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :practitioner_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
