module OliComments
  module CommentableAssoc
  
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def commentable
        has_many :comments, :as => :commentable, :dependent => :destroy, :class_name => 'Comment'
        
        class_eval do
          include InstanceMethods
        end
      end
    end
    
    module InstanceMethods
      def root_comments
        comments.where(parent_id: nil)
      end
    end
  end
end
