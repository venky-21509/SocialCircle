class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :username, :bio, :profile_picture, :avatar ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :username, :bio, :profile_picture, :avatar ])
  end

  def update_resource(resource, params)
    # Don't require current password for account updates
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(resource)
    # Send welcome email
    WelcomeMailer.welcome_email(resource).deliver_later
    root_path
  end
end
