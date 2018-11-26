$LOAD_PATH.unshift('.')

require 'scraper'
require 'news_csv'

start_page = 'Новости'
other_pages = %W(Люди Мнения Авто Технологии Недвижимость)

scraper = Scraper.new(start_page, other_pages)

csv = FileCSV.new
csv.save_info(scraper.info, 'news.csv')



