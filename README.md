Please read companion blog post: https://learnrubyblog.wordpress.com/2015/05/16/32-is-it-easy-to-build-a-social-network-using-rails/

SocialRails is a social networking site built with Ruby on Rails, Bootstrap and jQuery 

### How to get up and running

    $ git clone https://github.com/rinoldsimon/SocialRails.git
    $ cd SocialRails
    $ bundle
    $ rake db:migrate
    $ rails s
    
### Declare the provider in config/initializers/devise.rb

     config.omniauth :facebook, "YOUR APP SECRET", "YOUR APP ID", :secure_image_url => true
     config.omniauth :github, "YOUR APP SECRET", "YOUR APP ID", :scope =>'user,public_repo'
     
### Setting up ActionMailer

###### config/environments/development.rb

     config.action_mailer.default_url_options = { host: 'localhost:3000' }
     
     config.action_mailer.delivery_method = :smtp
     ActionMailer::Base.smtp_settings = {
        :address => "smtp.gmail.com",
        :port    => 587,
        :domain  => "localhost:3000",
        :user_name  => "your user name",
        :password   => "your password",
        :authentication => :plain,
        :enable_starttls_auto => true
      }
      
###### config/environments/production.rb

     config.action_mailer.default_url_options = { host: 'example.com' }
     
     config.action_mailer.delivery_method = :smtp
     ActionMailer::Base.smtp_settings = {
        :address => "smtp.gmail.com",
        :port    => 587,
        :domain  => "example.com",
        :user_name  => "your user name",
        :password   => "your password",
        :authentication => :plain,
        :enable_starttls_auto => true
      }
