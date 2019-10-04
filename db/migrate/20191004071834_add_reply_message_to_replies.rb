class AddReplyMessageToReplies < ActiveRecord::Migration[6.0]
  def change
    add_column :replies, :reply_message, :string
  end
end
