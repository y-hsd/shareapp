class ApplicationController < ActionController::Base

    # ログイン済ユーザーのみにアクセスを許可する(top画面、検索結果、ルーム詳細画面を除く)
    before_action :authenticate_user!, except: [:top]
    # deviseコントローラーにストロングパラメータを追加する  
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
      # アカウント編集の時にname、introduction、avatarのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :avatar])
    end

    def user_params
      params.require(:user).permit(:name, :avatar)
    end

    
end
