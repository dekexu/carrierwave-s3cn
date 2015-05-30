# CarrierWave::S3cn

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carrierwave-s3cn'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-s3cn

## Usage

You'll need to configure it in config/initializes/carrierwave.rb

```ruby
::CarrierWave.configure do |config|
  config.storage                = :s3cn
  config.s3cn_region            = "cn-north-1"
  config.s3cn_endpoint          = '' #optional
  config.s3cn_bucket            = "s3 bucket name"
  config.s3cn_access_key_id     = "中国 s3 access_key_id"
  config.s3cn_secret_access_key = "中国 s3 secret_access_key"
  config.s3cn_bucket_private    = true #default true
  config.s3cn_protocol          = "https" #default https
end
```

For more information on qiniu, please read http://docs.aws.amazon.com/general/latest/gr/isolated_regions.html

And then in your uploader, set the storage to `:qiniu`:

```ruby
class AvatarUploader < CarrierWave::Uploader::Base
  storage :s3cn
end
```

You can override configuration item in individual uploader like this:

```ruby
class AvatarUploader < CarrierWave::Uploader::Base
  storage :s3cn

  self.s3cn_bucket = "avatars"
  self.s3cn_access_key_id = ""
  self.s3cn_secret_access_key = ''
  self.qiniu_bucket_private= true #default is false

end
```
You can see a example project on: https://github.com/dekexu/carrierwave-s3cn
or see the spec test on https://github.com/dekexu/carrierwave-s3cn

## Contributing

1. Fork it ( https://github.com/dekexu/carrierwave-s3cn/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
