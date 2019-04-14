class User < ApplicationRecord
  has_secure_password
  has_many :periods, dependent: :destroy
  validates :email, presence: true

  def to_token_payload
    {
        sub: id,
        email: email
    }
  end

end
