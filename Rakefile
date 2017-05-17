require 'http'
require 'pp'

task :download_individual_json do
  # there are 36,971 items at the moment
  370.times do |i|
    url = "https://www.rijksmuseum.nl/api/nl/collection?key=#{ENV["API_KEY"]}&format=json&imgonly=true&ps=100&p=#{i + 1}&q=portret"
    json = HTTP.get(url)
    File.write("pages/page-#{i+1}.json", json)
  end
end

task :combine_json do
  combined = []
  370.times do |i|
    response = JSON.parse(File.read("pages/page-#{i+1}.json"))
    objects = response["artObjects"].map do |a|
      {
        object_number: a["objectNumber"],
        image_url: a.dig("webImage", "url"),
      }
    end

    combined = combined + objects
  end

  File.write("combined.json", JSON.dump(combined))
end


task :jsons do
  ids = File.read("ids.txt").lines.map(&:chomp)

  combined = []
  370.times do |i|
    response = JSON.parse(File.read("pages/page-#{i+1}.json"))
    objects = response["artObjects"].map do |a|
      next unless ids.include?(a["objectNumber"])

      {
        object_number: a["objectNumber"],
        image_url: a.dig("webImage", "url"),
        long_title: a["longTitle"],
      }
    end

    combined = combined + objects
  end

  File.write("db.json", JSON.dump(combined.compact))
end

task :image_urls do
  10.times do |i|
    response = JSON.parse(File.read("pages/page-#{i+1}.json"))
    response["artObjects"].each do |o|
      image_url = o.dig("webImage", "url")
      next unless image_url
      puts "curl #{image_url} > images/#{o["id"]}.jpg"
      image_filename = "images/#{o["id"]}.jpg"
    end
  end
end

# https://www.rijksmuseum.nl/nl/collectie/RP-F-F00666-S

task :image_paths do
  10.times do |i|
    response = JSON.parse(File.read("pages/page-#{i+1}.json"))
    response["artObjects"].each do |o|
      image_url = o.dig("webImage", "url")
      next unless image_url
      puts "portrets/images/#{o["id"]}.jpg"
    end
  end
end

task :index_commands do
  File.read("ids.txt").lines.map(&:chomp).each do |id|
    puts 'aws rekognition index-faces --collection-id=rijksmuseum-portrets --image="S3Object={Bucket=rijks-aws-experiment,Name=portrets/' + id + '.jpg}" --external-image-id="' + id + '"'
  end
end
