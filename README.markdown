# Monk skeleton using DataMapper/PostgreSQL

This is a Monk skeleton based from the official Redis-based skeleton that uses DataMapper/PostgreSQL instead of Redis.

Adding monk-datamapper-skeleton to Monk:

    monk add datamapper git://github.com/ealden/monk-datamapper-skeleton.git

Initializing a new Monk application with DataMapper:

    monk init myapp -s datamapper

Once initialized, ensure that the following gems are installed:

    gem install dependencies monk do_postgres
