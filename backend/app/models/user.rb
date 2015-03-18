class User < ActiveRecord::Base
  paginates_per 50
  include DeviseTokenAuth::Concerns::User
  acts_as_messageable
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  dragonfly_accessor :avatar do
    default ENV['DEFAULT_AVATAR']
    storage_options do |attachment|
      { headers: {"x-amz-acl" => "public-read-write"} }
    end
  end
  
end
