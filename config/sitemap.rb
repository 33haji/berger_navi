# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://berger-navi.herokuapp.com/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  add root_path, priority: 1.0, changefreq: 'weekly'
  add tip_genres_path, changefreq: 'monthly'

  Shop.find_each do |shop|
    add shop_path(shop), lastmod: shop.updated_at
  end
  Tip.find_each do |tip|
    add tip_path(tip), lastmod: tip.updated_at
  end
  TipGenre.find_each do |tip_genre|
    add tip_genre_path(tip_genre), lastmod: tip_genre.updated_at
  end
end
