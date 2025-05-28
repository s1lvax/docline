class AddSubscriptionStatusToPractitionerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :practitioner_profiles, :subscription_status, :string
    add_column :practitioner_profiles, :stripe_customer_id, :string
    add_column :practitioner_profiles, :stripe_subscription_id, :string
  end
end
