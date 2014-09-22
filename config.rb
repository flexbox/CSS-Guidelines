page "/sitemap.xml", :layout => false

require 'slim'

activate :gzip
activate :livereload
activate :autoprefixer,
  browsers: ['last 2 versions', 'ie 8', 'ie 9']

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
