class Reply < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :comment
  validates_presence_of :user_id, :post_id, :comment_id, :reply_message
end
