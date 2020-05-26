class RenameDescriptionInDoses < ActiveRecord::Migration[6.0]
  def change
    rename_column :doses, :description, :measurement
  end
end
