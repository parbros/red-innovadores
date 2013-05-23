module Refinery
  module Ideas
    class CommentsController < ::ApplicationController

      def create
        idea = Idea.find(params[:idea_id])
        comment = ::Comment.new(params[:comment])
        comment.commentable = idea
        comment.user = current_refinery_user if current_refinery_user.present?
        if comment.save
          redirect_to refinery.ideas_idea_url(idea), notice: 'Tu comentario se ha agregado.'
        else
          redirect_to refinery.ideas_idea_url(idea)
        end
      end
      
    end
  end
end
