require 'maruku'

activate :gzip
activate :livereload

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :favicon_maker
end
