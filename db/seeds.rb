# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

# Added by Refinery CMS Blog engine
Refinery::Blog::Engine.load_seed

# Added by Refinery CMS Memberships engine
Refinery::Memberships::Engine.load_seed

# Added by Refinery CMS Inquiries engine
Refinery::Inquiries::Engine.load_seed

# Added by Refinery CMS Search engine
Refinery::Search::Engine.load_seed

# Added by Refinery CMS Ideas extension
Refinery::Ideas::Engine.load_seed

# Added by Refinery CMS Experiences extension
Refinery::Experiences::Engine.load_seed

# Added by Refinery CMS Portfolio Engine
Refinery::Portfolio::Engine.load_seed

# Added by Refinery CMS Covers extension
Refinery::Covers::Engine.load_seed
