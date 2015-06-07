# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

Rails.application.config.assets.precompile = ['*.js', '*.css', '*.html', '*.jpg', '*.png', '*.gif']
Rails.application.config.assets.precompile += %w( bootstrap-sass-official/assets/fonts/bootstrap/glyphicons-halflings-regular.eot )
Rails.application.config.assets.precompile += %w( bootstrap-sass-official/assets/fonts/bootstrap/glyphicons-halflings-regular.woff2 )
Rails.application.config.assets.precompile += %w( bootstrap-sass-official/assets/fonts/bootstrap/glyphicons-halflings-regular.woff )
Rails.application.config.assets.precompile += %w( bootstrap-sass-official/assets/fonts/bootstrap/glyphicons-halflings-regular.ttf )
Rails.application.config.assets.precompile += %w( bootstrap-sass-official/assets/fonts/bootstrap/glyphicons-halflings-regular.svg )