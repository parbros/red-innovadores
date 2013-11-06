module Refinery
  module Ideas
    class IdeasController < ::ApplicationController

      before_filter :find_all_ideas
      before_filter :find_page
      before_filter :registered_user, only: [:new, :create]

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
          redirect_to refinery.ideas_idea_url(@idea, share: true)
        else
          redirect_to refinery.ideas_ideas_url
        end
      end
      
      def new
        @idea = Idea.new
        present(@page)
      end

    protected

      def find_all_ideas
        @ideas = Idea.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/ideas").first
      end
      
      def registered_user
        redirect_to "/refinery/users/login" unless current_refinery_user
      end
      

    end
  end
end
