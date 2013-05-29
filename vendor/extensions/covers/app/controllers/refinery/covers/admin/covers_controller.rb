module Refinery
  module Covers
    module Admin
      class CoversController < ::Refinery::AdminController

        crudify :'refinery/covers/cover', :xhr_paging => true
        
        def index
          @posts = ::Refinery::Covers::Cover.where('post_id IS NOT NULL').order('position ASC')
          @community = ::Refinery::Covers::Cover.where('experience_id IS NOT NULL OR idea_id IS NOT NULL').order('position ASC')
          @images = ::Refinery::Covers::Cover.where('image_id IS NOT NULL').order('position ASC')
        end
        
        def create
          all_covers = if params[:cover][:image_id].present?
              ::Refinery::Covers::Cover.where('image_id IS NOT NULL').order('position ASC')
            elsif params[:cover][:post_id].present?
              ::Refinery::Covers::Cover.where('post_id IS NOT NULL').order('position ASC')
            elsif params[:cover][:experience_id].present? or params[:cover][:idea_id].present?
              ::Refinery::Covers::Cover.where('experience_id IS NOT NULL OR idea_id IS NOT NULL').order('position ASC')
            end
              
          
          if (@cover = ::Refinery::Covers::Cover.create(params[:cover])).valid?
            if all_covers.present?
              all_covers.pop
              all_covers.unshift(@cover)
              all_covers.each_with_index do |cover, index|
                cover.update_attribute(:position, index)
              end
            end
            
            flash.notice = t(
            'refinery.crudify.created',
            :what => @cover.title
            )
            redirect_to '/refinery/covers'
          else          
            render :partial => '/refinery/admin/error_messages', :locals => {
              :object => @cover,
              :include_object_name => true
            }
          end
        end
      end
    end
  end
end
