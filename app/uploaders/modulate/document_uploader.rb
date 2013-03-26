class Modulate::DocumentUploader < ::CarrierWave::Uploader::Riak
  
  delegate :key, :bucket, :filename, to: :model

end
