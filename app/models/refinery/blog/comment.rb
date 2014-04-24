module Refinery
  module Blog
    class Comment < Comment

      def message
        self.body
      end
      
      def message=(new_message)
        self.body = new_message
      end
      
      def post
        commentable
      end
    end
  end
end
