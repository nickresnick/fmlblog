class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy #Note that this says user destroyed implies microposts destroyed, not the other way around

  has_many :active_relationships,   class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy #Remember that active relationship refers to you following someone
  has_many :passive_relationships,  class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed #source just says that we are using following in place of followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts,  dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token

  before_save   :downcase_email
  before_create :create_activation_digest

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validate :password_content #But has_secure_password requires that it isn't blank upon creation, so we're fine

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest") #use of the send method that will basically do digest = send("remember_digest") if remember is passed
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless activated?
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  # Returns a user's status feed.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id" #Since following/follower is an index, we say look in relationships,
                                                    #find all followed_id's where the follower_id is equal to our user id.
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id) #since followed_id = user_id, we look for the user_id in following_ids
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user) #so user.following.include? is the resulting method that would return all the ppl they follow
  end

  private #PPPPPPPPPPPPPRRRRRRRRRRRRRRIIIIIIIIIIIIIVVVVVVVVVVVVVVAAAAAAAAAAAATTTTTTTTTTTTTTEEEEEEEEEEEEE

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  def password_content
    if self.password != "turkeytrot"
      errors.add(:password, "Only Admins can Sign up")
    end
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end