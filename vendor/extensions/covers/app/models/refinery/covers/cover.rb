module Refinery
  module Covers
    class Cover < Refinery::Core::BaseModel
      self.table_name = 'refinery_covers'

      attr_accessible :image_id, :caption, :post_id, :idea_id, :experience_id, :position

      acts_as_indexed :fields => [:caption]

      belongs_to :image, :class_name => '::Refinery::Image'
      belongs_to :post, :class_name => '::Refinery::Blog::Post'
      belongs_to :idea, :class_name => '::Refinery::Ideas::Idea'
      belongs_to :experience, :class_name => '::Refinery::Experiences::Experience'
      
      
      def title
        return "<em>Imagen Principal</em>: #{image.image_name}" if image.present?
        return "<em>Post</em>: #{post.title}" if post.present?
        return "<em>Comunidad - Idea</em>: #{idea.title}" if idea.present?
        return "<em>Comunidad - Experiencia</em>: #{experience.title}" if experience.present?
      end
      
      def object
        return image if image.present?
        return post if post.present?
        return idea if idea.present?
        return experience if experience.present?
      end
      
      def experience?
        experience.present?
      end
      
      def idea?
        idea.present?
      end
    end
  end
end
