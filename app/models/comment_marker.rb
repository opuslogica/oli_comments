class CommentMarker < ActiveRecord::Base
  belongs_to :comment
  belongs_to :member
  
end
