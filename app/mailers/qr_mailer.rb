class QrMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.qr_mailer.email_sent.subject
  #
  def email_sent
    @greeting = "Hi"
    @user = params[:user]
    @qr = params[:img]
    attachments['QR Code'] = @qr.html_safe
    mail(
    from: "aggiepullday@gmail.com",
    to: @user.get_email,
    subject: "Your QR Code"
    )
  end
end
