#!/usr/bin/ruby
# MORSEL - Kitchen Command Line

require_relative 'morsel/input'
require_relative 'morsel/output'
require_relative 'morsel/networker'

class Morsel

  @@PROD = false
  @@NICOLE_MODE = false

  def self.activate
    networker = Networker.new(@@PROD)

    if networker.up
      input = menu_and_prompt

      while !Input.break.include?( input )

        if input == Input.thoughts && !@@NICOLE_MODE
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


        elsif input == Input.melon_selector && !@@NICOLE_MODE
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

        elsif input == Input.nicole_mode
          ## TOGGLE NICOLE MODE
          @@NICOLE_MODE = !@@NICOLE_MODE

        elsif @@NICOLE_MODE && input == Input.nicole_status
          ## Nicole status viewer
          Output.clear
          Output.get_nicole_status

          Output.press_any_key
          input = Input.get

        elsif @@NICOLE_MODE && input == Input.nicole_data
          ## Nicole data browser
          Output.clear
          Output.print_nicole_data

          Output.press_any_key
          input = Input.get
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
      @@NICOLE_MODE ? print_nicole_menu : print_normal_menu
      Input.get
    end

    def self.print_normal_menu
      Output.title
      Output.menu
    end

    def self.print_nicole_menu
      Output.nicole_title
      Output.nicole_menu
    end

end
