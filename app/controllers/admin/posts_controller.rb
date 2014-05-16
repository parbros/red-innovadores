class Admin::PostsController < Admin::BaseController

  def index
    @posts = Refinery::Blog::Post.order('created_at DESC').paginate(page: params[:page] || 1)
  end

  def edit
    @post = Refinery::Blog::Post.find params[:id]
    @categories = Refinery::Blog::Category.all
  end

  def update
    @post = Refinery::Blog::Post.find params[:id]
    if @post.update_attributes params[:post]
      redirect_to admin_posts_url
    else
      render :edit
    end
  end
end
