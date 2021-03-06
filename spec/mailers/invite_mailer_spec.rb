require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  describe "email_sent" do
    let(:mail) { InviteMailer.email_sent }

    it "renders the headers" do
      expect(mail.subject).to eq("Email sent")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
