class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications, dependent: :destroy

  attr_accessor :login, :username, :email, :password, :password_confirmation, :remember_me


  # Constants

  VALID_USERNAME_REGEX = /\A\w+\z/i

  # Validations

  validates :username, presence: true,
                       format: { with: VALID_USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }


def find_by_instagram_tag(tag)
  auth = authentications.find_by_provider('instagram')
  return nil if auth.nil?
  client = Instagram.client(client_id: ENV['INSTAGRAM_CLIENT_ID'],
                            access_token: auth.token)
  media = client.tag_recent_media(tag)
  puts media
  urls = media.map { |media_item| media_item.images.standard_resolution.url}
  urls
end

def find_by_instagram_account(account)
  auth = authentications.find_by_provider('instagram')
  return nil if auth.nil?
  client = Instagram.client(client_id: ENV['INSTAGRAM_CLIENT_ID'],
                            access_token: auth.token)
  user = client.user
  media = client.user_recent_media
  urls = media.map { |media_item| media_item.images.standard_resolution.url}
  urls
end



 def instagram_authentication
     authentications.find_by_provider('instagram')
   end

   #
   # Creates an authentication from an omniauth hash
   #
   def apply_omniauth(omniauth)
     authentications.build(provider: omniauth['provider'],
                           uid:      omniauth['uid'],
                           token:    omniauth['credentials']['token'])
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

  def email_required?
    false
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def instagram_authenticated?
    !authentications.find_by_provider('instagram').nil?
  end



end
