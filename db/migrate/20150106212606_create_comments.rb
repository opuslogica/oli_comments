class CreateComments < ActiveRecord::Migration
  def change
    
    #remove this after integration with current proj - ourdesign
    if !ActiveRecord::Base.connection.table_exists? 'comments'
    
     create_table :comments, :force => true do |t|
        t.integer  :commentable_id, :default => 0, foreign_key: false 
        t.string   :commentable_type
        t.string   :title
        t.text     :body
        t.string   :subject
        t.integer  :member_id, :default => 0, :null => false, foreign_key: false 
        t.integer  :parent_id, :lft, :rgt
        t.timestamps
      end
      
      add_index :comments, :member_id
      add_index :comments, [:commentable_id, :commentable_type]
    end
    
    if !ActiveRecord::Base.connection.table_exists? 'comment_markers'
      create_table :comment_markers do |t|
        t.references  :member
        t.references  :comment
        t.boolean     :is_read, default: false
        t.timestamps
      end

      add_index :comment_markers, :member_id
    end
      
  end
end
