# encoding: utf-8
require 'carrierwave'
require 'aws-sdk-v1'

module CarrierWave
  module Storage
    class S3cn < Abstract

      class Connection
        def initialize(options={})
          @s3cn_region = options[:s3cn_region] || 'cn-north-1'
          @s3cn_endpoint = options[:s3cn_endpoint]
          @s3cn_bucket = options[:s3cn_bucket]
          @s3cn_access_key_id = options[:s3cn_access_key_id]
          @s3cn_secret_access_key = options[:s3cn_secret_access_key]
          @s3cn_protocol = options[:s3cn_protocol]
          @s3cn_bucket_private = options[:s3cn_bucket_private] || true
          init
        end

        def store(file, key)
          stored_file = file.to_file
          @s3cn_bucket_obj.objects.create(key, stored_file)
          stored_file.close if stored_file && !stored_file.closed?
        end

        def delete(key)
          begin
            @s3cn_bucket_obj.objects[key].delete
          rescue Exception
            nil
          end
        end

        def info(key)
          @s3cn_bucket_obj.objects[key].head
        end

        def download_url(path)
          if @s3cn_bucket_private
            temp_url = @s3cn_bucket_obj.objects[path].url_for(:get, :signature_version => :v4).to_s
          else
            temp_url = @s3cn_bucket_obj.objects[path].public_url.to_s
          end
          temp_url
        end

        private

        def init
          init_s3cn_connection 
        end

        def init_s3cn_connection
          return if !@s3cn.nil?
          temp_config = {:access_key_id => @s3cn_access_key_id, :secret_access_key => @s3cn_secret_access_key, :region => @s3cn_region}
          @s3cn = AWS::S3.new(temp_config)
          @s3cn_bucket_obj = @s3cn.buckets[@s3cn_bucket]
        end
      end

      class File
        def initialize(uploader, path)
          @uploader, @path = uploader, path
        end

        def path
          @path
        end

        def url
          s3cn_connection.download_url(@path)
        end

        def store(file)
          s3cn_connection.store(file, @path)
        end

        def delete
          s3cn_connection.delete(@path)
        end

        def content_type
          file_info[:content_type] || 'application/octet-stream'
        end

        def size
          file_info[:content_length] || 0
        end

        def etag
          file_info[:etag].tr '"', ''
        end

        def meta
          file_info[:meta]
        end

        private

        def s3cn_connection
          if @s3cn_connection
            @s3cn_connection
          else
            config = {
              :s3cn_region              => @uploader.s3cn_region,
              :s3cn_endpoint            => @uploader.s3cn_endpoint,
              :s3cn_bucket              => @uploader.s3cn_bucket,
              :s3cn_access_key_id       => @uploader.s3cn_access_key_id,
              :s3cn_secret_access_key   => @uploader.s3cn_secret_access_key,
              :s3cn_bucket_private      => @uploader.s3cn_bucket_private,
              :s3cn_protocol            => @uploader.s3cn_protocol
            }
            @s3cn_connection ||= Connection.new config
          end
        end

        def file_info
          @file_info ||= s3cn_connection.info(@path)
        end
      end

      def store!(file)
        f = ::CarrierWave::Storage::S3cn::File.new(uploader, uploader.store_path(uploader.filename))
        f.store(file)
        f
      end

      def retrieve!(identifier)
        ::CarrierWave::Storage::S3cn::File.new(uploader, uploader.store_path(identifier))
      end
    end
  end
end
