class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :attachment, :image
  end
end
