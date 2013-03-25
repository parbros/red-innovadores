module Refinery
  module Experiences
    module Admin
      class ExperiencesController < ::Refinery::AdminController

        crudify :'refinery/experiences/experience', :xhr_paging => true

      end
    end
  end
end
