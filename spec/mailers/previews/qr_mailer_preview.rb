# Preview all emails at http://localhost:3000/rails/mailers/qr_mailer
class QrMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/qr_mailer/email_sent
  def email_sent
    QrMailer.email_sent
  end

end
