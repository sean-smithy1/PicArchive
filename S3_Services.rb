#!/usr/bin/ruby

require 'aws/s3'
include AWS::S3

module AmazonS3

  def self.create_bucket(buckit_name, server='s3-ap-southeast-2.amazonaws.com')
    begin
      connect(server)
      new_bucket = Bucket.create( buckit_name ) unless Service.buckets.include?( buckit_name )
    rescue ResponseError => error
      abort("an error occured: #{error}")
    end
  end

  def self.list_buckets
    Service.buckets.each { |bucket| puts "#{bucket.name}" }
  end

  def self.connect(server)
    AWS::S3::Base.establish_connection!(
      :access_key_id => 'AKIAJLKUF42IQXNPIHIA',
      :secret_access_key => '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',
      :server => server
      )
  end

end
