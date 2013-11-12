class User < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3, maximum: 50}
	validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
end
