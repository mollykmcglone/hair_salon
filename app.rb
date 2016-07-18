require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/client')
require('./lib/stylist')
require('pg')
require('pry')

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/new') do
  erb(:stylist_form)
end

post('/stylists') do
  name = params['name']
  station = params['station']
  @stylist = Stylist.new({:id => nil, :name => name, :station => station})
  @stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/:id') do
  @stylist = Stylist.find_by_id(params.fetch('id').to_i())
  erb(:stylist)
end

get('/stylists/:id/edit') do
  @stylist = Stylist.find_by_id(params.fetch('id').to_i())
  erb(:stylist_edit)
end

patch('/stylists/:id') do
  @stylist = Stylist.find_by_id(params.fetch('id').to_i())
  name = params.fetch('name')
  if name.==('')
    name = @stylist.name()
  end
  station = params.fetch('station')
  if station.==('')
    station = @stylist.station()
  end
  @stylist.update({:name => name, :station => station})
  @stylists = Stylist.all()
  erb(:stylists)
end

delete ('/stylists/:id') do
  @stylist = Stylist.find_by_id(params['id'].to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/clients') do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:clients)
end

get('/clients/new') do
  erb(:client_form)
end

post('/clients') do
  name = params['name']
  phone = params['phone']
  email = params['email']
  @client = Client.new({:id => nil, :name => name, :phone => phone, :email => email})
  @client.save()
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end

get('/clients/:id/edit') do
  @stylists = Stylist.all()
  @clients = Client.all()
  @client = Client.find_by_id(params.fetch('id').to_i())
  erb(:client_edit)
end

patch('/clients/:id') do
  @client = Client.find_by_id(params.fetch('id').to_i())
  name = params.fetch('name')
  if name.==('')
    name = @client.name()
  end
  phone = params.fetch('phone')
  if phone.==('')
    phone = @client.phone()
  end
  email = params.fetch('email')
  if email.==('')
    email = @client.email()
  end
  @client.update({:name => name, :phone => phone, :email => email})
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end

patch ('/clients/:id/assign') do
  @client = Client.find_by_id(params['id'].to_i())
  @client.assign(params['stylists'].to_i())
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end

delete ('/clients/:id') do
  @client = Client.find_by_id(params['id'].to_i())
  @client.delete()
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end
