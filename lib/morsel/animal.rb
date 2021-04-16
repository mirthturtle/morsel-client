class Animal

  ## LOADING

  def self.get_inventory
    file = File.read('./animalfriends.json')
    JSON.parse(file)
  end

  def self.get_orders
    file = File.read('./orders.json')
    JSON.parse(file)
  end

  ## SAVING

  def self.save_inventory(animal_friends)
    File.write('./animalfriends.json', JSON.dump(animal_friends))
  end

  def self.save_orders(orders)
    File.write('./orders.json', JSON.dump(orders))
  end

  ## INPUT

  def self.order_letters(orders)
    "abcdefghij"[0...orders.size]
  end

  def self.asset_letters(assets)
    "abcdefghijklmnoprstuvwyz1234567890"[0...assets.size]
  end

  def self.store_numbers(stores)
    "1234567890"[0...stores.size]
  end

  # returns the order object
  def self.get_order_selection(orders, selection)
    if the_index = self.order_letters(orders).index(selection)
      orders[ the_index ]
    end
  end

  # returns the asset name
  def self.get_asset_selection(assets, selection)
    if the_index = self.asset_letters(assets).index(selection)
      assets[ the_index ]
    end
  end

  # returns the index number of the store
  def self.get_store_selection(stores, selection)
    self.store_numbers(stores).index(selection)
  end

  ## PRINTING

  def self.print_stores_menu(animal_friends)
    animal_friends.each_with_index do |store, i|
      puts "#{i + 1}   #{store['name']}"
    end
  end

  def self.print_order_menu(orders)
    letters = self.order_letters(orders)

    orders.each_with_index do |order, i|
      puts "#{letters[i]}   #{order['asset']}"
    end
  end

  def self.print_store(store)
    letters = self.asset_letters(store['inventory'])

    if store['inventory'].size > 0
      store["inventory"].each_with_index do |item, i|
        puts "#{letters[i]}   #{item}"
      end
      puts "\nChoose an asset to order:\n\n"

    else
      puts "No inventory!\n\nPress ENTER to return to menu"
    end
  end

  def self.view_order(order, animal_friends)
    from = animal_friends[ order['store'] ]
    to   = animal_friends[ order['destination'] ]
    puts "-----------------------"
    puts "#{order['asset']}"
    puts "FROM: #{from['name']}"
    puts "TO: #{to['operator']} at #{to['name']}"
    puts "-----------------------\n\n"

    puts "f   Fulfill order"
    puts "c   Cancel order\n"
    puts "ENTER  Return to menu\n\n"
  end

  ## MOVING INVENTORY

  def self.transfer_asset(asset, source, destination)
    source['inventory'] -= [asset]
    destination['inventory'] << asset
  end

end