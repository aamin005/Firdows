class Post < ActiveRecord::Base
	validates :title, :body, presence: true


	belongs_to :user
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

	delegate :username, to: :user, allow_nil: true

	def self.tagged_with(name)
		Tag.find_by!(name: name).posts
	end

	def all_tags=(names)
		# name = "Reciters, Quran"
		self.tags = names.split(',').map do |name|
			Tag.where(name: name).first_or_create!
		end
	end

	def all_tags
		tags.map(&:name).join(", ")
	end
end   
