task :fetch_comics => :environment do
#  Testing out the API
  require 'open-uri'

  def fetch comic_id
    url = "http://www.xkcd.com/#{comic_id}"
    doc = Nokogiri::HTML(open(url))
    title = doc.css('div.s > h1').first.content
    src = doc.css('div.s > img').first['src']
    desc = doc.css('div.s > img').first['title']
    {:title => title, :src => src, :description => desc}
  end

  def count
    url = "http://www.xkcd.com/rss.xml"
    doc = Nokogiri::XML(open(url))
    doc.css('link')[2].content[/\/(\d+)\/$/, 1].to_i
  end

  Rake::Task['db:reset'].invoke

  c = count
  puts "Fetching #{c} comics"
  for i in 1..c
    comic = fetch i rescue next
    comic = Comic.new(comic)
    comic.id = i
    p comic
    comic.save
  end
end