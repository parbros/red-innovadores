module Refinery
  module Experiences
    class CommentsController < ::ApplicationController

      def create
        experience = Experience.find(params[:experience_id])
        comment = ::Comment.new(params[:comment])
        comment.commentable = experience
        comment.user = current_refinery_user if current_refinery_user.present?
        if comment.save
          redirect_to refinery.experiences_experience_url(experience), notice: 'Tu comentario se ha agregado.'
        else
          redirect_to refinery.experiences_experience_url(experience)
        end
      end
      
    end
  end
end
