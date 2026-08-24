class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    from_omniauth("Google")
  end

  def github
    from_omniauth("GitHub")
  end

  def failure
    redirect_to new_user_session_path, alert: "Could not sign in with that provider."
  end

  private

  def from_omniauth(kind)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      redirect_to new_user_registration_path, alert: @user.errors.full_messages.to_sentence
    end
  end
end
