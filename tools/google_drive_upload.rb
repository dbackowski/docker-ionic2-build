#!/usr/bin/env ruby

require "google_drive"

session = GoogleDrive::Session.from_config(ARGV[0])

collection = session.collection_by_title(ARGV[1])

file = collection.file_by_title(File.basename(ARGV[3]))

if file
  file.update_from_file(ARGV[2])
else
  collection.upload_from_file(ARGV[2], File.basename(ARGV[3]), convert: false)
end
