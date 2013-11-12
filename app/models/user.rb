class User < ActiveRecord::Base
	before_save {self.email.downcase!}
	validates :name, presence: true, length: {minimum: 3, maximum: 50}
	validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: {case_sensitive: false}
end
