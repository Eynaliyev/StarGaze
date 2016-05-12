class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:home, :profile]

  def index
  end

  def home
    following = Array.new
    for @f in current_user.following do
      following.push(@f.id)
    end

    @posts = Post.where("user_id IN (?)", following)
    @newPost = Post.new
    @toFollow = User.all.first(5)
  end

  def profile
    #grab the username from the URL as :id
    @user = User.find_by_username(params[:id])
    if(@user)
      @username = params[:id]
    else
      redirect_to root_path, :notice=> "User not found!"
    end
    @posts = Post.all.where("user_id = ?", @user.id)
    @newPost = Post.new

    @listings = Listing.all.where("user_id = ?", @user.id)
    @newListing = Listing.new

    @toFollow = User.all.first(5)
  end
  
#  def explore
#    @listings = Listing.all
#    @newListing = Listing.new

#    @categories = Category.all
#    @newCategory = Category.new
    
#    @toFollow = User.all.first(5)
#  end
end
