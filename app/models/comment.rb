class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :member
  has_many :comment_markers, dependent: :destroy

  validates_presence_of :body, :member

  scope :find_comments_by_member, -> (member){where(:member_id => member.id).order('created_at DESC')}
  scope :find_comments_for_commentable, -> (commentable_str, commentable_id){where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')}

  class << self
    def build_from(obj, member_id, comment, parent_id=nil)
      new \
        :commentable => obj,
        :body        => comment,
        :member_id     => member_id,
        :parent_id   => parent_id
    end
    
    def find_commentable(commentable_str, commentable_id)
      commentable_str.constantize.find(commentable_id)
    end
  end

  def has_children?
    self.children.any?
  end
  
  def children
    Comment.where(parent_id: self.id).order('created_at DESC')
  end
      
  def parent
    parent_id.nil? ? nil : Comment.find(self.parent_id)
  end
  
  private
    #for this method to work, the commentable model must have a method
    #called 'commenters' that returns a list of members to notify when 
    #a new comment is posted
    def notify_members
      if commentable.respond_to?('commenters')
        commentable.commenters.each do |commenter|
          comment_markers.create(member_id: commenter.id) if commenter.id != self.member_id
        end
      end
    end

end
