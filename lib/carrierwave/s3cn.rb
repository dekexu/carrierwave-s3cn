require "carrierwave/s3cn/version"
require "carrierwave/s3cn/storage"
require "carrierwave/s3cn/configuration"

::CarrierWave.configure do |config|
  config.storage_engines.merge!({:s3cn => "::CarrierWave::Storage::S3cn"})
end

::CarrierWave::Uploader::Base.send(:include, ::CarrierWave::S3cn::Configuration)

