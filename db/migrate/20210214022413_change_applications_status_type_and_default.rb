class ChangeApplicationsStatusTypeAndDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :status, :integer, using: "status::integer"
    change_column_default :applications, :status, 'new'
    change_column_default :applications, :status, 0
  end
end
