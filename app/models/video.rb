class Video < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	has_many :reviews

	has_attached_file :video_img, styles: { video_index: "250x350>", video_show: "325x475>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :video_img, content_type: /\Aimage\/.*\z/
end
