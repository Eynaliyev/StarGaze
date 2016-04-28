class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true #make sure the user the post's supposed to belong to exists
  validates :content, presence: true, length: { maximum: 140} #tweets are limited to 140 characters
  default_scope ->  { order(created_at: :desc) } #newest posts first - descending by date largest date closest to reality
  
end
