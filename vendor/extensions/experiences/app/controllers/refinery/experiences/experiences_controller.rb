module Refinery
  module Experiences
    class ExperiencesController < ::ApplicationController

      before_filter :find_all_experiences
      before_filter :find_page
      before_filter :registered_user, only: [:new, :create]

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
          redirect_to refinery.experiences_experience_url(@experience, share: true)
        else
          redirect_to refinery.experiences_experiences_url
        end
      end
      
      def new
        @experience = Experience.new
        @experience.pdf_files.build
        present(@page)
      end

    protected

      def find_all_experiences
        @experiences = Experience.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/experiences").first
      end
      
      def registered_user
        redirect_to "/refinery/users/login" unless current_refinery_user
      end

    end
  end
end
