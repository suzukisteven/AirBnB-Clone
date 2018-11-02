class UsersController < Clearance::UsersController
  before_action :set_user, only: [:edit, :update, :destroy]

  def profile
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_back fallback_location: "profile"
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

    def user_from_params
      email = user_params.delete(:email)
      password = user_params.delete(:password)
      first_name = user_params.delete(:first_name)
      last_name = user_params.delete(:last_name)
      avatars = user_params.delete(:avatars)

      Clearance.configuration.user_model.new(user_params).tap do |user|
        user.email = email
        user.password = password
        user.first_name = first_name
        user.last_name = last_name
        user.avatars = avatars
    end

    # def user_params
    #   # params.require(:user).permit(:first_name, :last_name, :email, {avatars: []})
    # end

  end
end
