class CreateHolidays < ActiveRecord::Migration[8.0]
  def change
    create_table :holidays do |t|
      t.references :practitioner_profiles, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :name

      t.timestamps
    end
  end
end
