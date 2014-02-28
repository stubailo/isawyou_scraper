require "rubygems"
require "nokogiri"
require "open-uri"
require "csv"

url = "https://isawyou.mit.edu/"
doc = Nokogiri::HTML(open(url))

CSV.open("out.csv", "wb") do |csv|
  csv << ["Title", "Date", "Seeker", "Seeking", "Content"]

  doc.css(".post").each do |post|
    title = post.at_css(".title").text
    meta = post.at_css(".meta").text.split(",")

    date = meta[2].strip + " on " + meta[0].split[2] + " " +
      meta[0].split[3] + "," + meta[1]

    # get X seeking Y
    seeking = meta[3].split("(")[0].strip
    source = seeking.split[0]
    target = seeking.split[2]

    content = post.at_css(".entry p").text

    csv << [title, date, source, target, content]
  end
end