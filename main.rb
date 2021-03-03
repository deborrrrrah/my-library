# frozen_string_literal: true

require './lib/my_library'

# Main class to run the system
class Main
  loop do
    command, *args = gets.chomp.split('|')
    begin
      MyLibrary::System.instance.execute(command, args)
    rescue StandardError => e
      puts "#{e.class}: #{e.message}\n\n"
    end
  end
end

Main.new
