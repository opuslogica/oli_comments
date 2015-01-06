require "oli_comments/engine"
require "oli_comments/config"
require "oli_comments/commentable"
require "oli_comments/commentable_assoc"

module OliComments
  def self.config(&block)
    if block
      block.call(OliComments::Config)
    else
      OliComments::Config
    end
  end
end

ActiveRecord::Base.send :extend, OliComments::Commentable
ActiveRecord::Base.send :include, OliComments::CommentableAssoc
