module Refinery
  module Ideas
    class VotesController < ::ApplicationController

      def create
        @idea = Idea.find(params[:idea_id])
        @vote = @idea.votes.new(params[:vote])
        @vote.user = current_refinery_user
        if @vote.save
          redirect_to refinery.ideas_idea_url(@idea)
        else
          redirect_to refinery.ideas_ideas_url
        end
      end

    end
  end
end
