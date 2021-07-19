#!/usr/bin/ruby
# MORSEL - Kitchen Command Line

require_relative 'morsel/input'
require_relative 'morsel/output'
require_relative 'morsel/networker'
require_relative 'morsel/animal'

require 'json'

class Morsel
  @@PROD = false   ## dev mode: connects to localhost:3000 christianrails server
                   ## prod mode: connects to live christiandewolf.com

  def self.activate
    networker = Networker.new(@@PROD)

    if networker.up
      animal_friends = Animal.get_inventory
      animal_orders = Animal.get_orders
      order_history = Animal.get_order_history
      current_order = nil

      input = menu_and_prompt

      while !Input.break.include?( input )

        if input == Input.thoughts
          ### THOUGHT COLLECTOR

          # Start getting input
          Output.clear
          Output.type_something

          morsel_text = Input.read_line
          while !Input.break.include?( morsel_text )
            if !morsel_text.empty?
              morsel_errors = networker.create_morsel(morsel_text)

              if !morsel_errors
                Output.save_successful
              else
                Output.print_error(morsel_errors)
              end
            end

            morsel_text = Input.read_line
          end


        elsif input == Input.melon_selector
          ## MELON SELECTOR
          Output.clear
          Output.choose_a_melon
          Output.three_melons
          Output.melon_menu

          input = Input.get
          if Input.melon_options.include?( input )
            translated_melon = (input.to_i - 1)
            melon_errors = networker.select_melon(translated_melon)
            if !melon_errors
              Output.melon_response(translated_melon)
            else
              Output.print_error(melon_errors)
            end
            Output.press_any_key
            input = Input.get
          end

        elsif input == Input.animal_commerce

          ##### ANIMAL COMMERCE #####

          Output.clear
          Output.commerce_main_menu(animal_friends, animal_orders)

          input = Input.get
          while !Input.break.include?( input )
            # parse input based on where we are

            if !current_order
              # on main menu, selecting a store or viewing order
              if Animal.order_letters(animal_orders).include?(input)
                # select and view the order
                current_order = Animal.get_order_selection(animal_orders, input)
                Output.clear
                Output.commerce_title
                Animal.view_order(current_order, animal_friends, animal_orders)
              elsif Animal.store_numbers(animal_friends).include?(input)
                # set up order, select store and print its inventory
                current_order = {}
                current_order['store'] = Animal.get_store_selection(animal_friends, input)
                store = animal_friends[ current_order['store'] ]
                Output.clear
                Output.commerce_title
                puts store['name']
                puts "Operated by: #{store['operator']}\n\n"
                Animal.print_store_inventory( store )
              elsif input == "0"
                # mystery order
                if animal_orders.size < 10
                  current_order = {}
                  current_order['store'] = Animal.get_random_store_with_inventory( animal_friends )
                  current_order['asset'] = Animal.get_random_asset_from_store( animal_friends[ current_order['store'] ] )
                  current_order['destination'] = Animal.get_random_destination_omitting( animal_friends, current_order['store'] )
                  animal_orders << current_order
                  Animal.save_orders(animal_orders)
                  current_order = nil
                end

                Output.clear
                Output.commerce_main_menu(animal_friends, animal_orders)
              end

            elsif !current_order['asset']
              # creating order, on asset selection screen for store
              if animal_friends[current_order['store']]['inventory'].size > 0
                if selection = Animal.get_asset_selection(animal_friends[current_order['store']]['inventory'], input)
                  current_order['asset'] = selection

                  # print destination selection screen
                  Output.clear
                  Output.commerce_title
                  puts "> " + current_order['asset'] + "\n\n"
                  Output.select_destination
                  Animal.print_list_of_stores(animal_friends, current_order['store']) # omit the current store
                  puts ""
                else
                  # return to menu
                  current_order = nil

                  # print main menu
                  Output.clear
                  Output.commerce_main_menu(animal_friends, animal_orders)
                end
              else
                # return to menu
                current_order = nil

                Output.clear
                Output.commerce_main_menu(animal_friends, animal_orders)
              end
            elsif !current_order['destination']
              # creating order, on destination selection screen
              if dest = Animal.get_store_selection(animal_friends, input)
                if dest == current_order['store']
                  # invalid selection! reprint selection
                  Output.clear
                  Output.commerce_title
                  puts "> " + current_order['asset'] + "\n\n"
                  Output.select_destination
                  Animal.print_list_of_stores(animal_friends, current_order['store'])
                  puts ""

                else
                  # finish creating the order
                  current_order['destination'] = dest
                  animal_orders << current_order
                  Animal.save_orders(animal_orders)

                  Output.clear
                  Output.commerce_title
                  Output.order_placed

                  Animal.view_order(current_order, animal_friends, animal_orders)
                end
              else
                current_order = nil

                Output.clear
                Output.commerce_main_menu(animal_friends, animal_orders)
              end
            else
              # viewing current order - can fulfill or cancel
              message = nil
              if input == 'f'
                # fulfill order
                Animal.transfer_asset(current_order['asset'], animal_friends[current_order['store']], animal_friends[current_order['destination']])
                Animal.save_inventory(animal_friends)

                # save in history
                order_history.unshift( {order: current_order, status: 1} )
                Animal.save_order_history( order_history )

                # remove order from order book along with conflicting orders
                Animal.cancel_orders_of(current_order['asset'], animal_orders)
                Animal.save_orders(animal_orders)

                message = :fulfilled
              elsif input == 'c'
                # cancel order
                animal_orders -= [current_order]
                Animal.save_orders(animal_orders)

                order_history.unshift( {order: current_order, status: 0} )
                Animal.save_order_history( order_history )

                message = :cancelled
              end

              current_order = nil

              # print main menu
              Output.clear
              Output.commerce_main_menu(animal_friends, animal_orders, message)
            end

            input = Input.get
          end

          # reset order on quit
          current_order = nil
        end

        input = menu_and_prompt
      end
      Output.clear
      Output.exiting
    else
      Output.api_down
    end

  end

  private

    def self.menu_and_prompt
      Output.clear
      print_normal_menu
      Input.get
    end

    def self.print_normal_menu
      Output.title
      Output.menu
    end

end
