class Topic < ActiveRecord::Base

  has_many :posts
  belongs_to :user

  scope :film, -> { where(name: 'film') }
  scope :music, -> {where(name: 'music')}
  scope :life, -> {where(name: 'life')}

  accepts_nested_attributes_for :posts, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  validate :name_options


  private

  def name_options
    if ["film","music","life"].include?(self.name)
    else
      errors.add(:name, "film, music, or life only")
    end
  end

end
