class Admin::PostsController < Admin::BaseController

  def index
    @posts = Refinery::Blog::Post.order('created_at DESC').paginate(page: params[:page] || 1)
  end

  def edit
    @post = Refinery::Blog::Post.find params[:id]
  end
end
