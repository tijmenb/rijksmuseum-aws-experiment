require 'http'
require 'pp'

task :download_json do
  10.times do |i|
    url = "https://www.rijksmuseum.nl/api/nl/collection?key=#{ENV["API_KEY"]}&format=json&imgonly=true&ps=100&p=#{i + 1}&q=portet"
    json = HTTP.get(url)
    File.write("pages/page-#{i+1}.json", json)
  end
end

task :download_images do
  10.times do |i|
    response = JSON.parse(File.read("pages/page-#{i+1}.json"))
    response["artObjects"].each do |o|
      image_url = o.dig("webImage", "url")
      next unless image_url

      image_filename = "images/#{o["id"]}.jpg"
      next if File.exist?(image_filename)

      image = HTTP.get(image_url)
      File.write(image_filename, image)
    end
  end
end
