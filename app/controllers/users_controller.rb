class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index]
  before_action :correct_user,only: [:edit, :update]
  before_action :admin_user,only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @spells = @user.spells
  end
  
  def new
    @user = User.new
  end

  def create
    if current_user && !current_user.admin?
      @user = User.new(user_params)
      @user.image.attach(params[:user][:image])
        if @user.save
          UserMailer.welcomin_mail(@user).deliver_now
          reset_session
          log_in @user
          flash.now[:success] = "Welcome to the hogwarts"
          @user.update(hogwarts_house: ["Gryffindor","Hufflepuff","Slytherin","Ravenclaw"].sample )
          redirect_to @user
          # Handle a successful save.
        else
          render 'new'
        end
    else
      @user = User.new(user_params)
      @user.image.attach(params[:user][:image])
        if @user.save
          UserMailer.welcomin_mail(@user).deliver_now
          @user.update(hogwarts_house: ["Gryffindor","Hufflepuff","Slytherin","Ravenclaw"].sample )
          redirect_to @user
          # Handle a successful save.
        else
          render 'new'
        end
    end
  end

 
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if @user.image
        @user.update(image: nil)
        @user.image.attach(params[:user][:image])
      else
        @user.image.attach(params[:user][:image])
      end
      flash[:success] = "Profile updated"
      redirect_to @user
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
    
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation,:bio,:ARMU,:birth_date,:image)
    end

    

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      if !current_user.admin?
      redirect_to(root_url) unless current_user?(@user)
      end
    end


    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
