require 'json'
require 'date'
require_relative '../../src/post'

class Matrix67Post < Post
  def initialize(post_url, post_html)
    super(post_url, post_html)
    @title = post_html.css(".entry-title").text
    @published_date = post_html.css(".entry-date").first.attributes["datetime"].value
    @content = post_html.css(".entry-content").children
    @author = "顾森"
  end
end
