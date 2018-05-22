# flovis-collector
Data collection server for Flovis

# Flovis?
Flow Visualisation. A system to show you how posts made their way through SmokeDetector. Smokey sends data to Flovis via flovis-collector, and
Flovis Farmhouse renders it and shows it to you.

# Installation
Run these commands:

    git clone git@github.com:Charcoal-SE/flovis-collector
    cd flovis-collector
    bundle install

Edit `config/database.yml` to provide details for the database you'll be using. Then:

    rake db:create
    rake db:schema:load
    rake db:migrate

Ready to go!

# Usage
Run `./run.sh` to start the server. Behind the scenes, that runs `bundle exec thin start -R server.rb -p 8091`. If you want to open it up to the
outside world then you'll need to set up port 8091 for external access.
