class ContactMailer < ActionMailer::Base
  default from: "contact@example.com"

  def contact_email(contact)
    @contact = contact
    mail(to: "crisrinold@gmail.com", subject: 'SocialRails-app Contact-me : Email Notify')
  end
end