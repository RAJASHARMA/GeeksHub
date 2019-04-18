class Image < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	has_attached_file :image
	# do_not_validate_attachment_file_type :image
	validates_attachment :image, content_type: { content_type: "image/jpeg" }, size: { less_than: 2.megabytes }	
end
