class ChangeMeasurementInDoses < ActiveRecord::Migration[6.0]
  def change
    change_column :doses, :measurement, :string
  end
end
