class TicketMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ticket_mailer.email_sent.subject
  #
  def email_sent
    @greeting = "Hi"
    pulled_uins = params[:pulled_uins]

    pulled_students = Student.where(uin: pulled_uins)
    pulled_emails = []
    pulled_students.each do |student|
      pulled_emails << student.email
    end
    
    puts "*****EMAIL"
    puts pulled_emails

    @group = Group.find(params[:group_id])
    mail(
    from: "aggiepullday@gmail.com",
    to: pulled_emails,
    subject: "Your ticket has been pulled!"
    )
  end
end
