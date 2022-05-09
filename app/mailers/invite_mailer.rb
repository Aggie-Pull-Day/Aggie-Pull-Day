class InviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.email_sent.subject
  #
  def email_sent
    @greeting = "Hi"
    @inviter = params[:inviter]
    @invitee = params[:invitee]
    @group = params[:group]
    mail(
    from: "aggiepullday@gmail.com",
    to: @invitee.email,
    subject: "You Have Been Invited to a Group!"
    )
  end
end
