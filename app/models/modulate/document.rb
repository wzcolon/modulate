class Modulate::Document < ActiveRecord::Base

  attr_accessible :label, :public, :attachment

  self.table_name = :modulate_documents

  mount_uploader :attachment, Modulate::DocumentUploader

  validates :attachable_id, :attachable_type, :bucket, :key, :filename, :content_type, :attachment, :label, presence: true
  validates :key, uniqueness: {scope: :bucket}

  belongs_to :attachable, polymorphic: true

  def key
    return if filename.blank? || attachable.blank? || attachable.id.blank?
    self[:key] ||= "#{attachable.id}-#{Time.now.to_i}-#{filename}"
  end

  def bucket
    return if attachable_type.blank?
    self[:bucket] ||= "#{Modulate.application_namespace}::#{attachable_type}"
  end

  def filename
    return if attachment.file.blank?
    self[:filename] ||= File.basename(attachment.file.file)
  end

  def content_type=(content_type)
    return unless attachment.file
    self[:content_type] = attachment.file.content_type = content_type
  end

  def content_type
    return unless attachment.file
    self[:content_type] ||= attachment.file.content_type
  end

  def label
    self[:label] ||= filename_to_label
  end

  private

  def filename_to_label
    File.basename(filename.to_s, File.extname(filename.to_s)).gsub(/\W/, ' ').squeeze(' ').humanize
  end
  
end
