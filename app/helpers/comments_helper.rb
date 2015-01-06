module CommentsHelper
  
  def time_ago(cdate)
    if cdate > 1.day.ago
      time_ago_in_words(cdate).gsub('about', '').gsub('less than', '') + ' ago'
    elsif cdate > 2.days.ago
      "Yesterday"
    else
      l(cdate, :format => :short)
    end
  end
  
  def reply_link(comment)
    if comment.parent.nil?
      link_to new_comment_path(parent_comment_id: comment.id), remote: true do
        concat(image_tag "orange-speech-bubble.png")
      end
    else
      ""
    end
  end
  
  def member_thumb(member)
     if !member.respond_to?('thumb') || member.thumb.nil?
       image_tag "member.png"
     else
       link_to member do
         tag "img", {src: member.thumb, class: 'img-thumbnail'}
       end        
     end
   end
  
end