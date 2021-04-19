require 'colorize'

class Output

  def self.title
    morsel_col = random_colour

    puts "wolfOS".colorize(random_colour) + " & " + "m3lon.com".colorize(random_colour) + " present:"
    puts "                               _ ".colorize(morsel_col) + "\n"
    puts " _ __ ___   ___  _ __ ___  ___| |".colorize(morsel_col) + "\n"
    puts "| '_ ` _ \\ / _ \\| '__/ __|/ _ \\ |".colorize(morsel_col) + "\n"
    puts "| | | | | | (_) | |  \\__ \\  __/ |".colorize(morsel_col) + "\n"
    puts "|_| |_| |_|\\___/|_|  |___/\\___|_|".colorize(morsel_col) + "\n"
    puts "                Kitchen Companion\n".colorize(morsel_col)
    puts "\"So you'll never eat meals alone.\"\n\n\n".colorize(random_colour)
  end

  def self.menu
    puts "MAIN MENU\n\n"
    puts "1  Thought collector\n"
    puts "2  Melon selector\n"
    puts "3  AnimalFriends Commerce\n"
    puts "\n"
    puts "n  Activate \"Nicole Mode\"".colorize(:light_yellow)
    puts "\n"
    puts "x  Exit to shell\n"
  end

  def self.clear
    system("clear")
  end

  def self.api_down
    puts "\nAPI cannot be reached. Check your connection and try again."
  end

  def self.exiting
    puts "Exiting...\n"
  end

  def self.press_any_key
    puts "\nPRESS ANY KEY\n".colorize( random_colour )
  end

  def self.print_error(error)
    puts "An error occurred: #{error}\n"
  end

  ## Thought collector stuff

  def self.type_something
    puts "Ready. Type 'x' or 'q' to stop.\n\n".colorize(random_colour)
  end

  def self.save_successful
    puts "✓\n".colorize(random_colour)
  end

  ## Melon selector stuff

  def self.choose_a_melon
    puts "Choose a melon:\n\n"
  end

  def self.three_melons
    puts " ,---. ".colorize( :light_red) + "     ,---. ".colorize( :light_yellow) + "     ,---. ".colorize( :light_green)
    puts "/     \\".colorize(:light_red) + "    /     \\".colorize(:light_yellow) + "    /     \\".colorize(:light_green)
    puts "|     |".colorize( :light_red) + "    |     |".colorize( :light_yellow) + "    |     |".colorize( :light_green)
    puts "\\     /".colorize(:light_red) + "    \\     /".colorize(:light_yellow) + "    \\     /".colorize(:light_green)
    puts " `---' ".colorize( :light_red) + "     `---' ".colorize( :light_yellow) + "     `---' ".colorize( :light_green)
  end

  def self.melon_image(melon_id)
    colors = [:light_red, :light_yellow, :light_green]

    puts "    ,---. ".colorize( colors[melon_id])
    puts "   /     \\".colorize(colors[melon_id])
    puts "   |     |".colorize( colors[melon_id])
    puts "   \\     /".colorize(colors[melon_id])
    puts "    `---' ".colorize( colors[melon_id])
  end

  def self.melon_menu
    puts "\n"
    puts "   1          2          3\n\n"
  end

  def self.melon_response(melon_id)
    colors = [:light_red, :light_yellow, :light_green]
    color_names = ['orange', 'yellow', 'green']
    qualifiers = ['fine', 'classic', 'quality']

    self.clear
    puts "You selected:\n\n"
    self.melon_image(melon_id)
    puts "\nThe #{color_names[melon_id]} melon".colorize(colors[melon_id])
    puts "\"A #{qualifiers[melon_id]} melon.\"\n\n"
  end

  ## Nicole mode

  def self.nicole_title
    puts "wolfOS".colorize(:cyan) + " & " + "m3lon.com".colorize(:cyan) + " present:"
    puts "          _           _      ".colorize(:light_blue) + "\n"
    puts "    _ __ (_) ___ ___ | | ___ ".colorize(:light_blue) + "\n"
    puts "   | '_ \\| |/ __/ _ \\| |/ _ \\".colorize(:light_blue) + "\n"
    puts "   | | | | | (_| (_) | |  __/".colorize(:light_blue) + "\n"
    puts "   |_| |_|_|\\___\\___/|_|\\___|".colorize(:light_blue) + "\n"
    puts "            You Are Wonderful\n".colorize(:blue)
    puts "\"Nicole is my favourite person.\" -Christian\n\n\n".colorize(:cyan)
  end

  def self.nicole_menu
    puts "MAIN MENU\n\n"
    puts "1  Get current Nicole status\n"
    puts "2  Browse Nicole data\n"
    puts "\n"
    puts "n  Exit \"Nicole Mode\"".colorize(:blue)
    puts "\n"
    puts "x  Exit to shell\n"
  end

  def self.get_nicole_status
    puts "IDENTIFYING CURRENT NICOLE STATUS...."
    puts "\n"
    puts "Nicole is currently:"
    puts "- beautiful"
    puts "- powerful"
    puts "- using a Morsel Kitchen Companion terminal in \"Nicole Mode\""
    puts "\n"
  end

  def self.print_nicole_data
    puts "QUERYING FILE \"NICOLE.DAT\".....".colorize(:blue)
    puts "\n"
    puts "Attribute          |  Data        |"
    puts "----------------------------------|"
    puts "Writing EXP        |  507         | "
    puts "Lawyer Power Level |  5 - EXTREME | "
    puts "Creative vision    |  INSPIRING   | "
    puts "Knee functionality |  60%         | "
    puts "Nail sharpness     |  95%         | "
    puts "Expert cuddler?    |  TRUE        | "
    puts "Sexiness           |  ########################"
    puts "\n"
    puts "WARNING! Nicole sexiness data is too large and too raw to display properly.".colorize(:light_red)
    puts "\n"
    puts "Please upgrade your Morsel Kitchen Companion terminal to the latest version.".colorize(:light_green)
    puts "\n"
  end

  ##### ANIMAL COMMERCE ######

   def self.commerce_title
    puts "wolfOS".colorize(:cyan) + " & " + "Jade Cat".colorize(:light_green) + " present:"
    puts "              _                 _ ".colorize(:yellow) + " __      _                _      ".colorize(:light_yellow) + "\n"
    puts "   __ _ _ __ (_)_ __ ___   __ _| |".colorize(:yellow) + "/ _|_ __(_) ___ _ __   __| |___  ".colorize(:light_yellow) + "\n"
    puts "  / _` | '_ \\| | '_ ` _ \\ / _` |".colorize(:yellow) + " | |_| '__| |/ _ \\ '_ \\ / _` / __| ".colorize(:light_yellow) + "\n"
    puts " | (_| | | | | | | | | | | (_| | ".colorize(:yellow) + "|  _| |  | |  __/ | | | (_| \\__ \\ ".colorize(:light_yellow) + "\n"
    puts "  \\__,_|_| |_|_|_| |_| |_|\\__,_|_".colorize(:yellow) + "|_| |_|  |_|\\___|_| |_|\\__,_|___/ ".colorize(:light_yellow) + "\n"
    puts "                         Adorable Commerce\n".colorize(:yellow)
  end

  def self.commerce_main_menu(animal_friends, animal_orders, message = nil)
    self.commerce_title

    if message == :fulfilled
      self.order_fulfilled
    elsif message == :cancelled
      self.order_cancelled
    elsif message == :mystery
      self.order_received
    end

    puts "Place an order: \n".colorize(:light_cyan)
    Animal.print_list_of_stores(animal_friends)
    if animal_orders.size < 10
      puts "\n0   Mystery order"
    else
      puts "\n    Mystery order"
    end

    if animal_orders.size > 0
      puts "\n\nOR View an order: \n".colorize(:light_cyan)
      Animal.print_order_menu(animal_orders)
    end
    puts "\n"
  end

  def self.order_placed
    puts "Order placed.\n".colorize(:green)
  end

  def self.order_cancelled
    puts "Order cancelled.\n".colorize(:light_red)
  end

  def self.order_fulfilled
    puts "Order fulfilled!\n".colorize(:magenta)
  end

  def self.order_received
    puts "Order received.\n".colorize(:green)
  end

  def self.select_destination
    puts "Select a destination: \n".colorize(:light_cyan)
  end

  def self.order_prompt
    puts "\n"
    puts "f   Fulfill order".colorize(:magenta)
    puts "c   Cancel order".colorize(:light_red)
    puts ""
    puts "ENTER  Return to menu\n\n"
  end

  def self.someone_else_ordering
    puts "\nSomeone else is also ordering this:".colorize(:yellow)
  end

  def self.choose_an_asset
    puts "\nChoose an asset to order:\n".colorize(:light_cyan)
  end

  def self.nothing_to_trade
    puts "Nothing to trade!\n".colorize(:light_magenta)
    puts "Press ENTER to return to menu"
  end

  private

    # borrowed from ActionView
    def self.word_wrap(text, line_width: 80, break_sequence: "\n")
      text.split("\n").collect! do |line|
        line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1#{break_sequence}").strip : line
      end * break_sequence
    end

    def self.random_colour
      colours = [:red, :light_red, :green, :light_green, :yellow, :light_yellow, :light_blue, :magenta, :light_magenta, :cyan, :light_cyan]
      colours[ Random.new.rand(colours.length) ]
    end

end
