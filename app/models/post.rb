class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  validates :user_id, presence: true # make sure the user the post's supposed to belong to exists
  validates :content, presence: true, length: { maximum: 140} # tweets are limited to 140 characters
  default_scope ->  { order(created_at: :desc) } # newest posts first - descending by date largest date closest to reality
  
  scope :involving, -> (user) do
    where("posts.user_id =? OR posts.recipient_id =?",user.id,user.id)
  end
end
