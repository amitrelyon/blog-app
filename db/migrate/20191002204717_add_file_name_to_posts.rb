class AddFileNameToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :file_name, :string
  end
end
