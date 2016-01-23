# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.assets.paths << 'vendor/components'

# Для картинок, чтобы их можно было брать через assets/images/themes/t1/dog.pn
Rails.application.config.assets.paths << 'vendor/dist/dist'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( bundle.js vendor.js bundle.css theme1.css )
