require('pry')

class Client
  attr_reader(:id, :name, :phone, :email, :stylist_id)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @phone = attributes[:phone]
    @email = attributes[:email]
    @stylist_id = attributes[:stylist_id]
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      id = client["id"].to_i()
      name = client["name"]
      phone = client["phone"]
      email = client["email"]
      stylist_id = client["stylist_id"].to_i()
      clients.push(Client.new({:id => id, :name => name, :phone => phone, :email => email, :stylist_id => stylist_id}))
    end
    clients
  end

  define_method(:==) do |other|
    self.name.==(other.name).&(self.id.==(other.id))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, phone, email) VALUES ('#{@name}', '#{@phone}', '#{@email}') RETURNING id;")
    @id = result.first['id'].to_i()
  end

  define_singleton_method(:find_by_name) do |name|
    returned_clients = DB.exec("SELECT * FROM clients WHERE name = '#{name}';")
    clients = []
    returned_clients.each do |client|
      id = client['id'].to_i
      name = client['name']
      phone = client['phone']
      email = client['email']
      stylist_id = client['stylist_id'].to_i
      clients.push(Client.new({:id => id, :name => name, :phone => phone, :email => email, :stylist_id => stylist_id}))
    end
    clients
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @phone = attributes.fetch(:phone, @phone)
    @email = attributes.fetch(:email, @email)
    @stylist_id = attributes.fetch(:stylist_id, @stylist_id)
    @id = self.id()
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET phone = '#{@phone}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET email = '#{@email}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET stylist_id = #{@stylist_id} WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id};")
  end
end
