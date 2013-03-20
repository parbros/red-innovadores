module Refinery
  module Ideas
    module Admin
      class IdeasController < ::Refinery::AdminController

        crudify :'refinery/ideas/idea', :xhr_paging => true

      end
    end
  end
end
