class Post < ActiveRecord::Base

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :comments
  belongs_to :user
  belongs_to :topic

  is_impressionable

  accepts_nested_attributes_for :topic, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, length: {minimum: 5}
  validate :picture_size

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def self.search(search)
    if search.blank? || search == {"topic_id"=>""}
      default_scoped.order('created_at DESC')
    else
      where(:posts => search).order('created_at DESC')
    end
  end

  def slug_candidates
    [
        :title,
        [:created_at, :title]
    ]
  end
end
