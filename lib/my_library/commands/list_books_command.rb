# frozen_string_literal: true

require './lib/my_library/models/library'
require './lib/my_library/commands/command'

module MyLibrary
  # Command to validate and execute command list_books
  class ListBooksCommand < Command
    def args_valid?(_args)
      true
    end

    def execute(_args = [])
      Library.instance.list_books
    end
  end
end
