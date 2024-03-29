require 'json'
require 'date'
require_relative '../../src/post'

class MindHacksPost < Post
  def initialize(post_url, post_html)
    super(post_url, post_html)
    @title = post_html.css(".style_breadcrumbs .container .row .col-md-6 h1").text
    @published_date = DateTime.parse(post_url.match(/[0-9]{4}\/[0-9]{2}\/[0-9]{2}/)[0])
    @content = post_html.css(".entry-content").children
    @author = "刘未鹏"
  end
end
