class InviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.send_email.subject
  #
  def send_email
    @greeting = "Hi"
    @user = params[:user] # you will need to creat ea method in the user model to use this mailer

    mail(
      from: "aggiepullday@gmail.com",
      to: @user.get_email,
      subject: "Your QR Code"
      )
  end
end
