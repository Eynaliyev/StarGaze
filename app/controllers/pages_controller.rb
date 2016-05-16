class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:home, :profile]

  def index
  end

  def home
    following = Array.new
    for @f in current_user.following do
      following.push(@f.id)
    end

    @posts = Post.where("user_id IN (?) OR recipient_id IN (?)", following, following)
    @new_post = Post.new
    @to_follow = User.all.first(5)
  end

  def profile
    # grab the username from the URL as :id
    @user = User.find_by_id(params[:id])
    if(@user)
      @username = params[:id]
    else
      redirect_to root_path, :notice=> "User not found!"
    end
    @posts = Post.where("user_id =? OR recipient_id =?",@user.id,@user.id)
    @new_post = Post.new
    @listings = Listing.all.where("user_id = ?", @user.id)
    @new_listing = Listing.new
    @to_follow = User.all.first(5)
  end
  
#  def explore
#    @listings = Listing.all
#    @new_listing = Listing.new

#    @categories = Category.all
#    @new_category = Category.new
    
#    @to_follow = User.all.first(5)
#  end
end
