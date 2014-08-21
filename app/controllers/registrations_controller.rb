class RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if User.where(user_type: 0).empty?
        user.user_type = 0
        resource_saved = user.save
      end
    end
  end

  def update
    if params[:commit] == "Update"
      super
    elsif params[:commit] == "Cancel my account"
      if current_user.valid_password?(params[:user][:current_password])
        kill_user(current_user)
        destroy
      else
        # I don't know how rails is doing that nice effect, so I basically have this dirty hack here...
        clean_up_passwords current_user
        params[:commit] = "Update"
        update
      end
    end
  end
end 