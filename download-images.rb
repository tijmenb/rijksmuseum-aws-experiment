require 'json'

# object_number
# image_url
objects = JSON.parse(File.read("combined.json"))

objects.each do |o|
  `curl #{o["image_url"]} > images/#{o["object_number"]}.jpg`
end
