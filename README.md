# CarrierWave::S3cn

中文：

该gem包主要用于s3在中国区域的使用, 哎，主要是s3的中国区域是被独立的区域。海外地区，使用carrierwave自带的fog就可以上传。
有几点需要注意的地方：

1. IAM地方 授权「上传角色」s3全部权限。

2. 配置跟权限都没问题，生成的s3地址如果访问不了，那应该是网站备案问题。网站需要在亚马逊备案。

English：

This gem is contributed to the Amazon S3 service in China which is an isolated region. 

Notice:

1. Assign the whole permission of s3 to the IAM user in the management console.

2. If all configurations are right and you register your aws account in https://www.amazonaws.cn, and also you can upload your resources successfully, but your download_url is not working, then maybe you should make an ICP License in Amazon-China according to chinese law. Refer to https://www.amazonaws.cn/en/about-aws/china/faqs/

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
  config.s3cn_access_key_id     = "中国(china) s3 access_key_id"
  config.s3cn_secret_access_key = "中国(china) s3 secret_access_key"
  config.s3cn_bucket_private    = true #default true
  config.s3cn_protocol          = "https" #default https
end
```

For more information on s3cn, please read http://docs.aws.amazon.com/general/latest/gr/isolated_regions.html

And then in your uploader, set the storage to `:s3cn`:

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
  self.s3cn_bucket_private= true #default is true

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
