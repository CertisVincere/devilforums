class Post < ActiveRecord::Base
  has_attached_file :attachment

  validates_attachment_file_name :attachment, matches: [/docx\Z/, /doc\Z/, /pdf\Z/, /jpg\Z/, /png\Z/]

  belongs_to :user
  belongs_to :topic
  belongs_to :group

  default_scope -> { order(created_at: :desc)}
  validates :name, presence: true
  validates :content, presence: true
  validates_with AttachmentSizeValidator, attributes: :attachment, less_than: 3.megabytes


end
