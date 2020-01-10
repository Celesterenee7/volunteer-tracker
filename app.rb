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
  erb(:home)
end

# Project routes below

get('/projects') do
  @projects = Project.all
  erb(:show_projects)
end

post('/projects') do
  title = params[:title]
  project = Project.new({:title => title, :id => nil})
  project.save()
  @projects = Project.all
  erb(:show_projects)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

get('/projects/:id/add') do
    @project = Project.find(params[:id])
    erb(:new_volunteer)
end