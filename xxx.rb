require 'json'

# object_number
# image_url
objects = JSON.parse(File.read("combined.json"))

already_downloaded = File.read("ids.txt").lines.map(&:strip)

objects.each do |o|
  next if already_downloaded.include?(o["object_number"])
  next if o["image_url"] == "" || o["image_url"] == nil
  id = o["object_number"]
  puts 'aws rekognition index-faces --collection-id=rijksmuseum-portrets --image="S3Object={Bucket=rijks-aws-experiment,Name=portrets/' + id + '.jpg}" --external-image-id="' + id + '"'
  puts 'sleep 1'
end
