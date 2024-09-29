# Save your favourite blog or podcast websites as RSS feeds

Blog Crawler is a set of ruby scripts that can turn your favourite blog or podcast websites into RSS feeds.

See examples of RSS feeds (`feeds.txt`, `slice-[0-9].xml`) & podcast URLs (`mp3-urls.txt`) generated by blog_crawler [here](https://github.com/goooooouwa/rss-feeds).

## Blogs & Podcasts already supported

- [Coding Horror](https://blog.codinghorror.com)
- [CoolShell](https://coolshell.cn)
- [Maccast Podcast](https://www.maccast.com/category/podcast)
- [Matrix67](http://www.matrix67.com/blog)
- [Mind Hacks](https://mindhacks.cn)
- [White House Press Briefings](https://obamawhitehouse.archives.gov/photos-and-video/video/2017/01/13/11317-white-house-press-briefing?tid=7&x=10&y=11&page=0)

## How to crawl and generate RSS feeds with blog_crawler

Let's use blog Coding Horror as an example.

### 1. Create custom page and post objects along with `config.json` for the website

Coding Horror page and post object:

```ruby
# blogs/coding_horror/coding_horror_page.rb
class CodingHorrorPage < Page
  def initialize(page_url, page_html)
    super(page_url, page_html)
    next_page_url_node = page_html.css(".left .read-next-title a").first
    previous_page_url_node = page_html.css(".right .read-next-title a").first
    @next_page_url = "https://blog.codinghorror.com#{ next_page_url_node.attributes["href"].value }" unless next_page_url_node.nil?
    @previous_page_url = "https://blog.codinghorror.com#{ previous_page_url_node.attributes["href"].value }" unless previous_page_url_node.nil?
    @post_urls = [@page_url]
  end
end

# blogs/coding_horror/coding_horror_posts.rb
class CodingHorrorPost < Post
  def initialize(post_url, post_html)
    super(post_url, post_html)
    @title = post_html.css(".post-title").text
    @published_date = post_html.at("meta[property='article:published_time']")['content']
    @content = post_html.css(".post-content").children
    @author = "Jeff Atwood"
  end
end
```

Config file:

```json
// blogs/coding_horror/config.json
{
  "title": "Coding Horror",
  "description": "programming and human factors",
  "homepage": "https://blog.codinghorror.com",
  "direction": "previous",
  "remote_base_url": "https://raw.githubusercontent.com/goooooouwa/out/master/coding_horror",
  "initial_page": "https://blog.codinghorror.com/building-a-pc-part-ix-downsizing/"
}
```

### 2. Fetch all pages you want to crawl from the website

```bash
ruby ./bin/run.rb page coding_horror
```

### 3. Fetch all posts within the pages you want to crawl

```bash
ruby ./bin/run.rb post coding_horror
```

### 4. Generate RSS feeds from the crawled posts

```bash
ruby ./bin/run.rb render coding_horror   # generate and save RSS feeds as `feeds.txt` & `slice-[0-9].xml` in config["our_dir"]
```

## What to do next?

You can use [rss2kindle](https://github.com/goooooouwa/rss2kindle/tree/master) to turn RSS feeds into ebooks which can be read on ebook readers, such as Kindle, Apple Books. See how it works [here](https://github.com/goooooouwa/rss2kindle/blob/master/README.md).
