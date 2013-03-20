module Refinery
  module Ideas
    class IdeasController < ::ApplicationController

      before_filter :find_all_ideas
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @idea in the line below:
        @idea = Idea.new
        present(@page)
      end

      def show
        @idea = Idea.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @idea in the line below:
        present(@page)
      end
      
      def create
        @idea = Idea.new(params[:idea])
        @idea.user = current_refinery_user
        if @idea.save
          redirect_to refinery.ideas_idea_url(@idea)
        else
          redirect_to refinery.ideas_ideas_url
        end
      end

    protected

      def find_all_ideas
        @ideas = Idea.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/ideas").first
      end

    end
  end
end
