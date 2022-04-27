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
