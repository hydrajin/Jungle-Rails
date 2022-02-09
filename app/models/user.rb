class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 4 }

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by_email(email)
    if user.nil? || !user.authenticate(password)
      nil
    else
      user
    end
  end
end

# https://stackoverflow.com/questions/38899698/how-to-get-proper-email-uniqueness-in-rspec
# https://stackoverflow.com/questions/13111328/testing-password-length-validation-with-rspec