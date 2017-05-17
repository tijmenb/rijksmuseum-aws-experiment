require 'json'

# object_number
# image_url
objects = JSON.parse(File.read("combined.json"))

already_downloaded = File.read("ids.txt").lines.map(&:strip)

objects.each do |o|
  next if already_downloaded.include?(o["object_number"])
  next if o["image_url"] == "" || o["image_url"] == nil
  puts "curl '#{o["image_url"]}' > 'images/#{o["object_number"]}.jpg'"
end
