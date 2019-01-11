class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    @greeting = "Hello #{@user.username}"
    mail to: user.email, subject: "SocialNetwork.com Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @user = user
    @greeting = "Hello #{@user.username}"

    mail to: "to@example.org", subject: "SocialNetwork.com Password reset"
  end
end
