require 'capybara'
require 'selenium/webdriver'
require 'csv'

def inspect_page(browser, page_name, headings, img_hrefs, descriptions)
	browser.click_on(page_name)

	headings.concat(browser.all(class: "news-tidings__subtitle").map { |a| a.text })

	img_hrefs.concat(browser.all(class: "news-tidings__image").map { |a| a["style"].match(/^.*:\s*url\((\".*\")\)/).captures[0] })

	descriptions.concat(browser.all(class: "news-tidings__speech").map{ |a| a.text.slice(0, 200) })
end

Capybara.default_driver = :selenium
Capybara.match = :first
Capybara.exact = :true

browser = Capybara.current_session
browser.visit 'https://www.onliner.by/'

browser.click_on("Новости")
pages = ["Люди", "Мнения", "Авто", "Технологии", "Недвижимость"]

headings = Array.new
img_hrefs = Array.new
descriptions = Array.new

pages.each { |name| inspect_page(browser, name, headings, img_hrefs, descriptions) }

csv_rows = headings.zip(img_hrefs, descriptions)
File.open("news.csv", "w") {|f| f.write(csv_rows.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}



