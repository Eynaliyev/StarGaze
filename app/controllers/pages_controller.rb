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

    @newPost = Post.new
    @to_follow = User.all.first(5)
  end

  def profile
    #grab the username from the URL as :id
    @user = User.find_by_id(params[:id])
    if(@user)
      @username = params[:id]
    else
      redirect_to root_path, :notice=> "User not found!"
    end
     @posts = Post.where("user_id =? OR recipient_id =?",@user.id,@user.id)
#    @posts = Post.all.where("recipient_id = ?", @user.id)
#    - the problem is, this isn't working...not the chained qury...but the id..
#    @posts = Post.all.where("user_id = ?", @user.id)


    @newPost = Post.new

    @listings = Listing.all.where("user_id = ?", @user.id)
    @newListing = Listing.new

    @to_follow = User.all.first(5)
  end
  
#  def explore
#    @listings = Listing.all
#    @newListing = Listing.new

#    @categories = Category.all
#    @newCategory = Category.new
    
#    @to_follow = User.all.first(5)
#  end
end
