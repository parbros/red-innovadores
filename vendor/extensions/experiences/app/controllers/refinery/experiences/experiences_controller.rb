module Refinery
  module Experiences
    class ExperiencesController < ::ApplicationController

      before_filter :find_all_experiences
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @experience in the line below:
        @experience = Experience.new
        present(@page)
      end

      def show
        @experience = Experience.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @experience in the line below:
        present(@page)
      end
      
      def create
        @experience = Experience.new(params[:experience])
        @experience.user = current_refinery_user
        if @experience.save
          redirect_to refinery.experiences_experience_url(@experience)
        else
          redirect_to refinery.experiences_experiences_url(share: true)
        end
      end
      
      def new
        @experience = Experience.new
        present(@page)
      end

    protected

      def find_all_experiences
        @experiences = Experience.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/experiences").first
      end

    end
  end
end
