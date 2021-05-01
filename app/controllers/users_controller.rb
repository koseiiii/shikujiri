class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @user = User.new(user_params)
        @user.image = "default_icon.jpg"
        if @user.save
        redirect_to posts_path, success: '登録ができました'
        else
        flash.now[:danger] = "登録に失敗しました"
        render :new
        end
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts.order("created_at DESC")
    end

    private
    def user_params
        params.require(:user).permit(:name, :profile,  :image)
    end

end
