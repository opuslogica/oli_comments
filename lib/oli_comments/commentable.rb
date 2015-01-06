module OliComments
  module Commentable
  
    def commentable?
      self.included_modules.include?(OliComments::CommentableAssoc)
    end
    
    def commentable
      include OliComments::CommentableAssoc
    end
    
      
  end
end