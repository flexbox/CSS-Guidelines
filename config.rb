activate :navtree do |options|
  options.data_file = 'tree.yml'
  options.source_dir = 'source' # The `source` directory we want to represent in our nav tree.
  options.ignore_files = [
    'sitemap.xml.builder',
    'robots.txt',
    'human.txt',
    'feed.xml.builder',
    'favicon_base.png',
    'CNAME'
  ]
  options.ignore_dir = ['assets', 'views'] # An array of directories we want to ignore when building our tree.
  options.home_title = 'Home' # The default link title of the home page (located at "/"), if otherwise not detected.
  options.promote_files = ['index.html'] # Any files we might want to promote to the front of our navigation
  options.ext_whitelist = [] # If you add extensions (like '.md') to this array, it builds a whitelist of filetypes for inclusion in the navtree.
end

activate :google_analytics do |ga|
  ga.tracking_id = data.settings.google_analytics.tracking_code
  ga.anonymize_ip = true
  ga.debug = false
  ga.development = false
  ga.minify = true
end

activate :gzip
activate :livereload
activate :autoprefixer,
  browsers: ['last 2 versions', 'ie 8', 'ie 9']

page "/sitemap.xml", :layout => false

require 'slim'

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

# Add bower's directory to sprockets asset path
after_configuration do

  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]

end

configure :build do
  activate :minify_html
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :favicon_maker
end
