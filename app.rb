#!/usr/bin/env ruby
require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require ('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects)
end

# Project routes below

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

get('/projects/new') do
  erb(:new_project)
end

post('/projects') do
  title = params[:title]
  id = params[:id]
  project = Project.new({:title => title, :id => id})
  project.save()
  redirect to ('/projects')
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end