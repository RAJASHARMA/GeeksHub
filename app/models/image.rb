class Image < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	has_attached_file :image
	do_not_validate_attachment_file_type :image
	# validates_attachment :image, presence: true, content_type: { content_type: "image/jpeg" }, size: { in: 0..10.kilobytes }	
end
