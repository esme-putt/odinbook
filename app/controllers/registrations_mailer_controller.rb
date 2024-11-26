class RegistrationsMailerController < Devise::RegistrationsController

    def create
      super
      if @user.persisted?
        WelcomeMailer.with(user: @user).welcome_email.deliver
      end
    end
end