#!/usr/bin/ruby
require 'digest/md5'
require 'sqlite3'

dir = ARGV[0]

begin

  db = SQLite3::Database.open "piclib_md5.db"

  db.execute "CREATE TABLE IF NOT EXISTS piclib(digest STRING PRIMARY KEY,
      file_name STRING, directory_name STRING)"
  db.prepare("INSERT INTO piclib VALUES ( 'md5_hash', 'file_name', 'dir_name' )")

  Dir[ File.join(dir, '**', '*') ].each { |f|
    if File.file?(f)
      dir_name, file_name = File.split(f)
      md5_hash=Digest::MD5.hexdigest(File.read(f))

      db.execute( "INSERT INTO piclib VALUES ( ?,?,?)", md5_hash, file_name, dir_name )
      puts ("#{dir_name} #{file_name} #{md5_hash}")
    end
  }

 rescue SQLite3::Exception => e
  puts "Exception occured"
  puts e
ensure
  db.close if db
end
