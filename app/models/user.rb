class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, dependent: :destroy
  enum role: [:customer, :moderator, :superadmin]
  # Enum refers to the Ruby class we're using
  # role is the attribute we're going to treat as an enum
  # :customer etc, names we're using to reference users role

  after_initialize do
    if self.new_record?
      self.role ||= :customer
    end
  end

  # rails c -> x = User.first -> x.superadmin!
  # Output => x.role = "superadmin"

  def self.create_with_auth_and_hash(authentication, auth_hash)
    # byebug
    user = self.create!(
      first_name: auth_hash["info"]["first_name"],
      last_name: auth_hash["info"]["last_name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
    )
    user.authentications << authentication
    return user
  end

  # grab google to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end
end
