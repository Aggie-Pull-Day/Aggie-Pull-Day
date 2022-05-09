class InviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.email_sent.subject
  #
  def email_sent
    @greeting = "Hi"
    @user_email = params[:user_email]
    @id = params[:id]
    mail(
    from: "aggiepullday@gmail.com",
    to: @user.get_email,
    subject: "You Have Been Invited to a Group!"
    )
  end
end
