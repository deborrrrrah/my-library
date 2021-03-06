# frozen_string_literal: true

require './lib/my_library/const'
require './lib/my_library/models/book_address'
require './lib/my_library/models/book_collection'

module MyLibrary
  # Library class to handle the execute output of command
  class Library
    @@instance = Library.new

    def self.instance
      @@instance
    end

    def reset_size(params = {})
      @book_collection = BookCollection.new
      @shelf_size = params[:shelf_size]
      @row_size = params[:row_size]
      @column_size = params[:column_size]
      @available_position = BookAddress.new.string_to_book_address('010101')
      if valid?
        @shelf_size.times do |shelf_id|
          puts "Shelf #{shelf_id + 1} with #{@row_size} rows and #{@column_size} columns is added "
        end
      end
    end

    def valid?
      return false if @shelf_size.nil? || @row_size.nil? || @column_size.nil?
      return false unless @shelf_size > Const.instance.size[:min_size] && @shelf_size < Const.instance.size[:max_size]
      return false unless @row_size > Const.instance.size[:min_size] && @row_size < Const.instance.size[:max_size]
      return false unless @column_size > Const.instance.size[:min_size] && @column_size < Const.instance.size[:max_size]

      true
    end

    def find_next_empty_position
      size_limit = {
        shelf_size: @shelf_size,
        row_size: @row_size,
        column_size: @column_size
      }
      address = @available_position.next_address(size_limit)
      address = address.next_address(size_limit) until @book_collection.empty_address?(address)
      address
    end

    def full?
      @available_position.nil?
    end

    def put_book(params)
      if full?
        puts 'All shelves are full!'
        Const.instance.response[:full]
      else
        book = Book.new(params)
        response = @book_collection.insert(@available_position, book)
        if response == Const.instance.response[:invalid_book]
          puts 'Failed to put_book because the book attributes are invalid.'
        elsif response == Const.instance.response[:success]
          puts "Allocated address: #{@available_position}"
          @available_position = find_next_empty_position
        elsif response == Const.instance.response[:already_exist]
          puts "Book #{book} already exist"
        end
        response
      end
    end

    def address_valid?(address)
      book_address = BookAddress.new.string_to_book_address(address)
      return false unless book_address.shelf_in_range?(0, @shelf_size + 1)
      return false unless book_address.row_in_range?(0, @row_size + 1)
      return false unless book_address.column_in_range?(0, @column_size + 1)

      true
    end

    def check_library_initialize
      unless Library.instance.valid?
        raise StandardError,
              'Library is invalid. Please set the library in the valid size (1-99)'
      end
    end

    def take_book_from(address)
      check_library_initialize
      if !address_valid?(address)
        puts 'Invalid code!'
        Const.instance.response[:invalid_address]
      else
        response = @book_collection.delete(address)
        if response == Const.instance.response[:success]
          if full? || address.to_s < @available_position.to_s
            @available_position = BookAddress.new.string_to_book_address(address)
          end
          puts "Slot #{address} is free"
        elsif response == Const.instance.response[:failed]
          puts "Slot #{address} is already empty"
        end
        response
      end
    end

    def find_book(isbn)
      check_library_initialize
      result = @book_collection.find_book(isbn)
      if result.nil?
        puts 'Book not found!'
        Const.instance.response[:not_found]
      else
        puts "Found the book at #{result}"
        Const.instance.response[:found]
      end
    end

    def search_book_by_author(keyword)
      check_library_initialize
      result = BookCollection.search_book_by_author(@book_collection, keyword)
      if result.empty?
        puts 'Book not found!'
        Const.instance.response[:not_found]
      else
        puts result
        Const.instance.response[:found]
      end
    end

    def search_book_by_title(keyword)
      check_library_initialize
      result = BookCollection.search_book_by_title(@book_collection, keyword)
      if result.empty?
        puts 'Book not found!'
        Const.instance.response[:not_found]
      else
        puts result
        Const.instance.response[:found]
      end
    end

    def list_books
      check_library_initialize
      puts @book_collection
    end

    private :address_valid?, :check_library_initialize
  end
end
