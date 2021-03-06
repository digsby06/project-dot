class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications, dependent: :destroy
  has_many :displays, dependent: :destroy

  attr_accessor :login

  # Constants

  VALID_USERNAME_REGEX = /\A\w+\z/i

  # Validations

  validates :username, presence: true,
                       format: { with: VALID_USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }

  # Creates an authentication from an omniauth hash

  def apply_omniauth(omniauth)
     authentications.build(provider: omniauth['provider'],
                           uid:      omniauth['uid'],
                           token:    omniauth['credentials']['token'],
                           secret:   omniauth['credentials']['secret'])
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions.to_h).find_by(
        ['lower(username) = :value OR lower(email) = :value',
         { value: login.downcase }])
    else
      find_by(conditions.to_h)
    end
  end

  # Authentications

  def instagram_authentication
     authentications.find_by_provider('instagram')
  end

  def twitter_authentication
    authentications.find_by_provider('twitter')
  end

  # Predicate Methods - returns true or false

  def email_required?
    false
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def instagram_authenticated?
    !authentications.find_by_provider('instagram').nil?
  end

  def twitter_authenticated?
    !authentications.find_by_provider('twitter').nil?
  end

end
