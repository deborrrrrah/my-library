# frozen_string_literal: true

require './class/system'

class Main
  loop do
    command, *args = gets.chomp.split('|')
    begin
      System.instance.execute(command, args)
    rescue StandardError => e
      puts "#{e.class}: #{e.message}\n\n"
    end
  end
end

Main.new
