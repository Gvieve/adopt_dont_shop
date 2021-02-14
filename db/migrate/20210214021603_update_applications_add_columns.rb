class UpdateApplicationsAddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :state, :string, after: :city
    add_column :applications, :status, :string, after: :adoption_reason
  end
end
