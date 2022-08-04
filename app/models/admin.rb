class Admin < ApplicationRecord
	include MuserConcern

	MAILER_FROM_EMAIL = "no-reply@example.com"

  attr_accessor :current_password

  has_secure_password
  has_secure_token :remember_token

  #Antes de guardar el registro en la DB ejecuta downcase_email
  before_save :downcase_email

  #Regla para el email
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  #validates :unconfirmed_email, format: {with: URI::MailTo::EMAIL_REGEXP, allow_blank: true}

  def send_confirmation_email!(token_exp)
    
  end

  private
    def downcase_email
      self.email = email.downcase #Conviértelo a minúsculas
    end
end
