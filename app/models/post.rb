class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :replies, dependent: :destroy
  validates_presence_of :image, :description, :user_id, :file_name
  mount_uploader :image, ImageUploader
  validate :image_size_validation

  private

  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end

end
