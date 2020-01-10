#!/usr/bin/env ruby
require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require ('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

