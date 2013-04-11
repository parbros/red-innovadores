module Refinery
  module Covers
    module Admin
      class CoversController < ::Refinery::AdminController

        crudify :'refinery/covers/cover', :xhr_paging => true

      end
    end
  end
end
