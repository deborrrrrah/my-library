# frozen_string_literal: true

require './lib/my_library/models/library'
require './lib/my_library/commands/command'

module MyLibrary
  # Command to validate and execute command search_books_by_author
  class SearchBooksByAuthorCommand < Command
    def args_valid?(args)
      args.length == 1
    end

    def execute(args)
      Library.instance.search_book_by_author(args[0])
    end
  end
end
