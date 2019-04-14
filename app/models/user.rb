class User < ApplicationRecord

  has_many :periods, dependent: :destroy

  has_secure_password
  validates :email, presence: true

  def to_token_payload
    {
        sub: id,
        email: email
    }
  end

end
