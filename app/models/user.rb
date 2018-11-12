class User < ApplicationRecord
  include Clearance::User
  # validates :password, optional: true

  has_many :listings, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :authentications, dependent: :destroy

  enum role: [:customer, :moderator, :superadmin]
  mount_uploader :avatar, AvatarUploader
  # Enum refers to the Ruby class we're using
  # role is the attribute we're going to treat as an enum
  # :customer etc, names we're using to reference a users role

  # for every new account set default role to :customer
  after_initialize do
    if self.new_record?
      self.role ||= :customer
    end
  end

  # Manually assign superadmin/moderators by:
  # rails c -> x = User.firnd(:id) -> x.superadmin! (to assign)
  # Output => x.role = "superadmin"

  def self.create_with_auth_and_hash(authentication, auth_hash)
    # byebug to check what auth_hash["info"] is for params from Google
    user = self.create!(
      first_name: auth_hash["info"]["first_name"],
      last_name: auth_hash["info"]["last_name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
      # since the user will use their google password, set secure random for password field
    )
    user.authentications << authentication
    return user
  end

  # grab google token to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end
end
