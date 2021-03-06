class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.new(user_params)
    if@user.save
      redirect_to user_registration_path(@user.id)
    else
      render :new
    end
  end

#ここから下　チーム開発参考資料
#before_action :authenticate_customer!

  def show
    @user = current_user
    # @items = @user.item_images.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "登録情報が更新されました。"
      redirect_to users_my_page_path
    else
      render 'edit'
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :zip_code, :address, :tel, :email)
  end
end
