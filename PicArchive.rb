#!/usr/bin/ruby
require_relative 'S3_Services'
require_relative 'PicMD5'


AmazonS3.create_bucket('smith2013-picarchive')
AmazonS3.list_buckets
