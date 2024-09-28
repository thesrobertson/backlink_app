class User < ApplicationRecord

	# This adds methods to set and authenticate against a BCrypt password.
  # Requires the presence of a `password_digest` column in the database.
  has_secure_password

  # Add any validations as needed, e.g.:
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

end
