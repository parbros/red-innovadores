class CommentsController < ApplicationController
  
  def destroy
    comment = Comment.find(params[:id])
    message = if comment.delete
        {notice: "Comentario eliminado exitosamente"}
      else
        {alert: "Se ocasiono un problema al eliminar el comentario"}
      end
    redirect_to refinery.blog_post_url(comment.commentable.id), message
  end
end
