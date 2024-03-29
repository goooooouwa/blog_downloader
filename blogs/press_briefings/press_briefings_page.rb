require "json"
require_relative "../../src/page"

class PressBriefingsPage < Page
  def initialize(page_url, page_html)
    super(page_url, page_html)
    base_url = "https://obamawhitehouse.archives.gov"
    match_data = page_url.match(/page=[0-9]{1,3}/)
    current_page_number = match_data.nil? ? 1 : match_data[0].split("=").last.to_i
    @next_page_url = "#{base_url}/photos-and-video/video/2017/01/13/11317-white-house-press-briefing?tid=7&x=10&y=11&page=#{current_page_number + 1}"
    @previous_page_url = "#{base_url}/photos-and-video/video/2017/01/13/11317-white-house-press-briefing?tid=7&x=10&y=11&page=#{current_page_number - 1}"
    @post_urls = page_html.css("#media-gallery .views-field-title .field-content a").map { |a| base_url + a.attributes["href"].value }
  end
end