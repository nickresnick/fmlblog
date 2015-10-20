class Contact < MailForm::Base

  attribute :name
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.

  def headers
    {
        :subject => "Blog Reach Out",
        :to => "nres@umich.edu",
        :from => %("#{name}" <#{email}>)
    }
  end
end