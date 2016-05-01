class PostsController < ApplicationController
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id # assign the post to the user who created it.
        respond_to do |f|
            if (@post.save) 
                f.html { redirect_to :back, notice: "Post created!" }
            else
                f.html { redirect_to :back, notice: "Error: Post not created!" }
            end
        end
    end

    def show
        @post = Post.find(params[:id])
    end
  
    def edit 
        @post = Post.find(params[:id]) 
    end
    
    def update
        @post = Post.find(params[:id])

        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
  end
    
    def destroy 
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to "/" 
    end
    
    private
    def post_params #allows certain data to be passed via form.
        params.require(:post).permit(:user_id, :content)
    end
end