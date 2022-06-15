class UsersController < ApplicationController
  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def rooms
    @user = current_user
    @rooms = @user.rooms
  end


  def update
    @user = User.find(params[:id])
    @introduction = params[:introduction]
    if @user.invalid?
      @error_messages = @user.errors.full_messages
      render template: "users/profile"
    elsif @user.update(user_params)
      flash[:notice]="プロフィールを更新しました"
      redirect_to users_account_path(current_user)
    end
  end


  private

  def user_params
  params.require(:user).permit(:email, :name, :introduction)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end


end
