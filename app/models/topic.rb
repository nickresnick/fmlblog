class Topic < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :posts
  belongs_to :user

  scope :film, -> { where(name: 'film') }
  scope :music, -> {where(name: 'music')}
  scope :life, -> {where(name: 'life')}

  validate :name_options


  private

  def name_options
    if ["film","music","life"].include?(self.name)
    else
      errors.add(:name, "film, music, or life only")
    end
  end

end
