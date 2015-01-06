# @current_member required 
# CanCan used for permissions. 

class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy]
  authorize_resource
  
  def index
    @commentable = params[:commentable_type].constantize.find(params[:commentable_id])
    @comments  = @commentable.root_comments.page params[:page]
    @comment = Comment.build_from(@commentable, @current_member.id, "") if logged_in?
  end

  #this method called only when the replies link is hit
  def show
    @parent = Comment.find(params[:id])
    @comment = Comment.build_from(@parent.commentable, @current_member.id, "") if logged_in?
  end

  def new
    if params[:commentable_type] && params[:commentable_id]
      @commentable = params[:commentable_type].constantize.find(params[:commentable_id])
      @comment = Comment.build_from(@commentable, @current_member.id, "")
    end
    if params[:parent_comment_id]
      @parent = Comment.find(params[:parent_comment_id])
      @comment = Comment.build_from(@parent.commentable, @current_member.id, "", @parent.id)
    end
  end

  def create
    @comment = Comment.new(comment_params) 
    @comment.member = @current_member
    if !params[:parent_comment_id].blank?
      @parent = Comment.find(params[:parent_comment_id])
      @comment.parent_id = @parent.id
    end  
    @success = true
    respond_to do |format|
      if @comment.save
        @saved_comment = @comment
        build_new
      else
        @saved_comment = @comment
        @success = false
      end
      format.js {render :layout => false}
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  def build_new
    @commentable = @comment.commentable
    @comment = Comment.build_from(@commentable, @current_member.id, "")
  end

  private
    def comment_params
      params.require(:comment).permit(:commentable_id, :commentable_type, :member_id, :body) 
    end
    
    def set_comment
      @comment = Comment.find(params[:id]) if params[:id]
    end

end
