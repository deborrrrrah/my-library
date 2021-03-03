# frozen_string_literal: true

require './lib/my_library/models/library'
require './lib/my_library/commands/command'
require './lib/my_library/models/book_address'

module MyLibrary
  # Command to validate and execute command find_book
  class FindBookCommand < Command
    def args_valid?(args)
      args.length == 1
    end

    def execute(args)
      Library.instance.find_book(args[0])
    end
  end
end
