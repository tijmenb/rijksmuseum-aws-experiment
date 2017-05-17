require 'json'

ids = File.read("ids-batch-2.txt").lines.map(&:strip)

ids.each do |id|
  puts 'aws rekognition index-faces --collection-id=rijksmuseum-portrets --image="S3Object={Bucket=rijks-aws-experiment,Name=portrets/' + id + '.jpg}" --external-image-id="' + id + '"'
end
