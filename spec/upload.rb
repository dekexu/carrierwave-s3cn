class ImageUploader < CarrierWave::Uploader::Base
  storage :s3cn
  self.s3cn_region            = "cn-north-1"
  # self.s3cn_endpoint          = '' #optional
  self.s3cn_bucket            = "my-bucket"
  self.s3cn_access_key_id     = "AKIAOYZP5FWNNNW4RFZA"
  self.s3cn_secret_access_key = "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"
  self.s3cn_bucket_private    = true #default true
  self.s3cn_protocol          = "https" #default https
end