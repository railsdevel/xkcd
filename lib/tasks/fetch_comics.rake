task :fetch_comics => :environment do
#  Testing out the API
  require 'open-uri'


  
  def fetch comic_id
    url = "http://www.xkcd.com/#{comic_id}"
    doc = Nokogiri::HTML(open(url))
    title = doc.css('div.s > h1').first.content
    src = doc.css('div.s > img').first['src']
    desc = doc.css('div.s > img').first['title']
    {:id => comic_id, :title => title, :src => src, :description => desc}
  end

  def count
    url = "http://www.xkcd.com/rss.xml"
    doc = Nokogiri::XML(open(url))
    doc.css('link')[2].content[/\/(\d+)\/$/, 1].to_i
  end

  Rake::Task['db:reset'].invoke
  
  c = count/100
  p Comic.all
  (1..c).each do |i|
    details = fetch i
    p details
    new_comic = Comic.new(details)
    p new_comic
    new_comic.save
  end
end