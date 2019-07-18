#!/usr/bin/ruby
# MORSEL - Kitchen Command Line

require_relative 'morsel/input'
require_relative 'morsel/output'
require_relative 'morsel/networker'

class Morsel

  @@PROD = true

  def self.activate
    networker = Networker.new(@@PROD)

    if networker.up
      Output.clear
      Output.title
      Output.menu
      input = Input.get

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
        end

        Output.clear
        Output.title
        Output.menu
        input = Input.get
      end
      Output.clear
      Output.exiting
    else
      Output.api_down
    end

  end

end
