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
    attachments['ticket_pull_qr_code.png'] = File.read('images/image.png')
    mail(
    from: "aggiepullday@gmail.com",
    to: @user.get_email,
    subject: "Your QR Code"
    )
  end
end
