
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
def email_required?
  false
end 
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         has_many :posts, dependent: :destroy #if a user's account is deleted destroy all of his posts
         has_many :categories, dependent: :destroy #if a user's account is deleted destroy all of his posts
         has_many :listings, dependent: :destroy #if a user's account is deleted destroy all of his posts
         has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

         has_many :following, through: :active_relationships, source: :followed
         has_many :followers, through: :passive_relationships, source: :follower

        self.primary_key = "id"


        def self.from_omniauth(auth)
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.name = auth.info.name
            user.first_name = auth.info.first_name
            user.last_name = auth.info.last_name
            user.image = auth.info.image
#            user.password = Devise.friendly_token[0,20]
            user.location = auth.info.location
            user.verified = auth.info.verified
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.save!
          end
        end
         # helper methods

         #follow another user
         def follow(other) 
            active_relationships.create(followed_id: other.id)
         end

         def unfollow(other)
            active_relationships.find_by(followed_id: other.id).destroy
         end

         def following?(other)
            following.include?(other)
         end

end