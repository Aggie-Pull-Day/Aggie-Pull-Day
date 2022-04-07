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
    attachments['QR Code'] = @qr
    mail(
    from: "support@pullday.com",
    to: User.first.email,
    subject: "Your QR Code"
    )
  end
end
