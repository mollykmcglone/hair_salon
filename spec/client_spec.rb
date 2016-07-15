require('spec_helper')

describe(Client) do

describe('#name') do
    it "returns the name of the client" do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      expect(test_client.name()).to(eq('Patsy Cline'))
    end
  end

  describe('#id') do
    it "returns the id of the client" do
      test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
      test_client.save()
      expect(test_client.id().class()).to(eq(Fixnum))
    end
  end

  describe('.all') do
    it 'is an array of clients that is empty at first' do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('#==') do
      it 'compares two clients by name and id to see if they are the same' do
        test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
        test_client2 = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
        test_client1.eql?(test_client2)
      end
    end

    describe('#save') do
      it 'saves a client' do
        test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
        test_client.save()
        expect(Client.all()).to(eq([test_client]))
      end
    end

    describe('.find_by_name') do
      it 'locates clients with a given name' do
        test_client = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
        test_client2 = Client.new({:id => nil, :name => 'Patsy Cline',:phone => '503-250-2173', :email => 'patsycline@gmail.com', :stylist_id => nil})
        test_client1.save()
        test_client2.save()
        expect(Client.find_by_name(test_client.name())).to(eq([test_client]))
      end
    end


end
