class CategoriesController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create]

    def new
        @category = Category.new
    end

    def index
        @listings = Listing.all
        @new_listing = Listing.new

        @categories = Category.all
        @new_category = Category.new
        
        @to_follow = User.all.first(5)
    end

    def show
        categories = Category.all
        if(categories.find(params[:id]))
            @category = categories.find(params[:id])
        else
          redirect_to root_path, :notice=> "Category not found!"
        end
        users = User.all
        @to_follow = users.all.first(5)
        @user=users.find_by_id(params[:id])
        @listings = @category.listings
        @new_listing = Listing.new
    end
    
    def create
        @category = Category.new(category_params)
        @category.user_id = current_user.id # assign the post to the user who created it.
        respond_to do |f|
            if (@category.save)
                f.html {redirect_to "/explore", notice: "Category created!" }
            else
                f.html {redirect_to "", notice: "Error: Category not saved."}
            end
        end
    end
    
    private
    def category_params # allows certain data to be passed via form.
        params.require(:category).permit(:user_id, :name)
    end
end
