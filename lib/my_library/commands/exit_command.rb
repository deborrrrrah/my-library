# frozen_string_literal: true

require_relative 'command'

module MyLibrary
  # Command to validate and execute command list_books
  class ExitCommand < Command
    def args_valid?(_args)
      true
    end
    
    def execute(_args = [])
      exit
    end
  end
end
