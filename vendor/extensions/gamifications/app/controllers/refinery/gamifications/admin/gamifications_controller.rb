module Refinery
  module Gamifications
    module Admin
      class GamificationsController < ::Refinery::AdminController

        def index
          @rankings = Refinery::User.generate_rankings
        end

      end
    end
  end
end
