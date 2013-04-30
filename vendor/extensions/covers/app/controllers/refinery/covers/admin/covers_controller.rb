module Refinery
  module Covers
    module Admin
      class CoversController < ::Refinery::AdminController

        crudify :'refinery/covers/cover', :xhr_paging => true
        
        def index
          @posts = ::Refinery::Covers::Cover.where('post_id IS NOT NULL')
          @community = ::Refinery::Covers::Cover.where('experience_id IS NOT NULL OR idea_id IS NOT NULL')
          @images = ::Refinery::Covers::Cover.where('image_id IS NOT NULL')
        end
      end
    end
  end
end
