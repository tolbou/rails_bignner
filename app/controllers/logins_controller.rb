class LoginsController < ApplicationController
    
    def new

    end

    def create
        user = User.where(name: params[:name], age: params[:age]).first
    
        if user.present?
          session[:user_id] = user.id
          redirect_to users_path, notice: 'ログインしました'
        else
          flash.now[:warning] = 'ログインできませんでした'
          render :new
        end
      end
    
end