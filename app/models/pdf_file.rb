class PdfFile < ActiveRecord::Base
  attr_accessible :file, :fileable_id, :fileable_type
  
  belongs_to :fileable, :polymorphic => true
  
  mount_uploader :file, PdfFileUploader
  
  def pdf_file_name
    file.to_s.split('/').last
  end
end
