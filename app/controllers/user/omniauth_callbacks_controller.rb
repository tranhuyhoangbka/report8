class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    binding.pry
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_by_uid(request.env["omniauth.auth"]["uid"])

    if @user
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
