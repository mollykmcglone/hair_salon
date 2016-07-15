require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/client')
require('./lib/stylist')
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/new') do
  erb(:stylist_form)
end

get('/stylists/:id/edit') do
  @stylist = Stylist.find_by_id(params['id'].to_i())
  erb(:stylist_edit)
end

patch ('/stylists/:id') do
  name = params['name']
  station = params['station'].to_i()
  @stylist = Stylist.find_by_id(params['id'].to_i())
  @stylist.update({:name => 'name', :station => 'station'})
  erb(:stylists)
end

delete ('/stylists/:id') do
  @stylist = Stylist.find_by_id(params['id'].to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:stylists)
end

post('/stylists') do
  name = params['name']
  station = params['station'].to_i()
  @stylist = Stylist.new({:id => nil, :name => name, :station => station})
  @stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end
