# frozen_string_literal: true

require_relative 'command'

# Command to validate and execute command list_books
class ExitCommand < Command
  def args_valid?(_args)
    true
  end
  
  def execute(_args = [])
    exit
  end
end
