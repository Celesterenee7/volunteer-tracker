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
  erb(:home)
end

# ------------ Project routes below ------------- #

get('/projects') do
  @projects = Project.all
  erb(:show_project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

get('/projects/:id/add') do
    @project = Project.find(params[:id])
    erb(:add_volunteer)
end

get('/projects/:id') do
  @project = Project.find(params[:id])
  erb(:show_project)
end

post('/') do
  title = params[:title]
  @project = Project.new({:title => title, :id => nil})
  @project.save
  @projects = Project.all
  erb(:home)
end

post('/projects/:id/edit') do
    name = params[:name]
    project_id = params[:id]
    @volunteer = Volunteer.new({:name => name, :id => nil, :project_id => project_id})
    @project = Project.find(params[:id])
    @volunteer.save()
    erb(:edit_project)
end

delete('/projects/:id/edit') do
    @project = Project.find(params[:id].to_i())
    @project.delete()
    @projects = Project.all
    erb(:home)
end

patch('/projects/:id/edit') do
  @project = Project.find(params[:id])
  title = params[:title]
  @project.update({:title => title})
  @projects = Project.all
  erb(:home)
end

# -------- Volunteer routes below ---------- #

get('/volunteers') do
  @volunteers = Volunteer.all
  erb(:view_volunteer)
end

get('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id])
  erb(:edit_volunteer)
end

delete('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id])
  @volunteer.delete()
  @volunteers = Volunteer.all
  @project = Project.find(@volunteer.project_id)
  erb(:show_project)
end

patch('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id])
  name = params[:name]
  @volunteer.update({:name => name})
  @volunteers = Volunteer.all
  @project = Project.find(@volunteer.project_id)
  erb(:show_project)
end