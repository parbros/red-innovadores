module Refinery
  module Blog
    class Comment < Comment

      def message
        body
      end
      
      def message=(new_message)
        body = new_message
      end
    end
  end
end
