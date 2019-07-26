class User < ApplicationRecord
  has_secure_password
  has_many :periods, dependent: :destroy
  validates :email, presence: true

  before_save :downcase_email

  # def to_token_payload
  #   puts("Ejecutando to_token_payload")
  #   {
  #       sub: id,
  #       email: email
  #   }
  # end

  private

  # Se encarga de que email tenga sólo letras minúsculas
  def downcase_email
    self.email.downcase!
  end

end
