# frozen_string_literal: true

require './lib/my_library/models/library'
require './lib/my_library/commands/command'

module MyLibrary
  # Command to validate and execute command take_book
  class TakeBookCommand < Command
    def args_valid?(args)
      return false unless args.length == 1

      address = begin
        BookAddress.new.string_to_book_address(args[0])
      rescue StandardError
        nil
      end
      return false if address.nil?

      true
    end

    def execute(args)
      Library.instance.take_book_from(args[0])
    end
  end
end
