#encoding: utf-8
module CarrierWave
  module S3cn
    module Configuration
      extend ActiveSupport::Concern
      included do
        add_config :s3cn_region
        add_config :s3cn_endpoint
        add_config :s3cn_bucket
        add_config :s3cn_access_key_id
        add_config :s3cn_secret_access_key
        add_config :s3cn_bucket_private
        add_config :s3cn_protocol
        alias_config :s3cn_protocal, :s3cn_protocol
      end

      module ClassMethods
        def alias_config(new_name, old_name)
          class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def self.#{new_name}(value=nil)
            self.#{old_name}(value)
          end

          def self.#{new_name}=(value)
            self.#{old_name}=(value)
          end

          def #{new_name}
          #{old_name}
          end
          RUBY
        end
      end
    end
  end
end