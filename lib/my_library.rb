require "./lib/my_library/commands/build_library_command.rb"
require "./lib/my_library/commands/command.rb"
require "./lib/my_library/commands/exit_command.rb"
require "./lib/my_library/commands/find_book_command.rb"
require "./lib/my_library/commands/list_books_command.rb"
require "./lib/my_library/commands/put_book_command.rb"
require "./lib/my_library/commands/search_books_by_author_command.rb"
require "./lib/my_library/commands/search_books_by_title_command.rb"
require "./lib/my_library/commands/take_book_command.rb"
require "./lib/my_library/models/book_address"
require "./lib/my_library/models/book_collection"
require "./lib/my_library/models/book"
require "./lib/my_library/models/library"
require "./lib/my_library/system"
require "./lib/my_library/const"
require "./lib/my_library/version"

module MyLibrary
  class Error < StandardError; end
  # Your code goes here...
end