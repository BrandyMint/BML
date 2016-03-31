# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = AppVersion.to_s

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Bower
Rails.application.config.assets.paths << 'vendor/components'
Rails.application.config.assets.paths << 'vendor/assets/components'
Rails.application.config.assets.paths << 'vendor/assets'

# Для картинок, чтобы их можно было брать через assets/images/themes/t1/dog.pn
Rails.application.config.assets.paths << 'vendor/dist/dist'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
  *.gif *.png *.jpg *.svg *.ttf *.woff *.woff2 *.map *.mp4 *.ogv *.webm
  fonts.css
  welcome.js
  vendor.js
  components.js
  viewer_application.js
  viewer.js viewer.css
  editor.js editor.css
  swagger_ui.js swagger_ui.css
)
