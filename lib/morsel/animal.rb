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

  def self.get_order_history
    file = File.read('./order-history.json')
    JSON.parse(file)
  end

  ## SAVING

  def self.save_inventory(animal_friends)
    File.write('./animalfriends.json', JSON.dump(animal_friends))
  end

  def self.save_orders(orders)
    File.write('./orders.json', JSON.dump(orders))
  end

  def self.save_order_history(history)
    File.write('./order-history.json', JSON.dump(history))
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

  def self.print_list_of_stores(animal_friends, omit = nil)
    animal_friends.each_with_index do |store, i|
      if omit && omit == i
        puts "    #{store['name']}"
      else
        puts "#{i + 1}   #{store['name']}"
      end
    end
  end

  def self.print_order_menu(orders)
    letters = self.order_letters(orders)

    orders.each_with_index do |order, i|
      puts "#{letters[i]}   #{order['asset']}"
    end
  end

  def self.print_store_inventory(store)
    letters = self.asset_letters(store['inventory'])

    if store['inventory'].size > 0
      # print in columns if lots in inventory
      if store['inventory'].size > 20
        first_col = []
        second_col = []
        store["inventory"].each_with_index do |item, i|
          if i > (store['inventory'].size / 2.0)
            second_col << "#{letters[i]}   #{item}"
          else
            first_col << "#{letters[i]}   #{item}"
          end
        end

        first_col.each_with_index do |item, i|
          if second_col.size - 1 >= i
            puts item.ljust(40) + second_col[i]
          else
            puts item
          end
        end
      else # normal
        store["inventory"].each_with_index do |item, i|
          puts "#{letters[i]}   #{item}"
        end
      end
      Output.choose_an_asset

    else
      Output.nothing_to_trade
    end
  end

  def self.view_order(order, animal_friends, animal_orders)
    from = animal_friends[ order['store'] ]
    to   = animal_friends[ order['destination'] ]
    puts "-----------------------"
    puts "#{order['asset']}"
    puts "FROM: #{from['name']}"
    puts "REQUESTED BY: #{to['operator']} at #{to['name']}"
    puts "-----------------------"

    # check conflicting orders
    conflicting_orders = self.get_conflicting_orders(order, animal_orders)

    if conflicting_orders.size > 0
      Output.someone_else_ordering
      conflicting_orders.each do |conflicting_order|
        competitor = animal_friends[ conflicting_order['destination'] ]
        puts competitor['operator'] + " at " + competitor['name'] + "\n"
      end
    end

    Output.order_prompt
  end

  def self.get_conflicting_orders(order, animal_orders)
    (animal_orders - [order]).select{|x| x['asset'] == order['asset']}
  end

  ## MOVING INVENTORY

  def self.transfer_asset(asset, source, destination)
    source['inventory'] -= [asset]
    destination['inventory'] << asset
  end

  def self.cancel_orders_of(asset, orders)
    orders.select!{ |x| x['asset'] != asset }
  end

  ## RANDOMIZERS

  # gets the index of the store
  def self.get_random_store_with_inventory(animal_friends)
    the_store = animal_friends.sample
    while the_store['inventory'].size == 0
      the_store = animal_friends.sample
    end
    animal_friends.index( the_store )
  end

  # gets the asset
  def self.get_random_asset_from_store(store)
    store['inventory'].sample
  end

  # gets the index of a destination
  def self.get_random_destination_omitting(animal_friends, omitting)
    ((0...animal_friends.size).collect{|x| x} - [omitting]).sample
  end

end