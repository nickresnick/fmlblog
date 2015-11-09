class Post < ActiveRecord::Base

  has_many :comments
  belongs_to :user
  belongs_to :topic

  attr_accessor :topic_id
  accepts_nested_attributes_for :topic, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :title, presence: true
  validates :name, presence: true
  validates :content, length: {minimum: 5}
  validate :picture_size

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
