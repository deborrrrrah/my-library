# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::BookCollection do
  context 'when need empty and non-empty book collection' do
    before(:all) do
      @empty_book_collection = MyLibrary::BookCollection.new
      @book_collection = MyLibrary::BookCollection.new
      @book_address = '010101'
      @book = MyLibrary::Book.new({
                                    isbn: '1234567890123',
                                    author: 'J. K. Rowling',
                                    title: 'Harry Potter'
                                  })
      @book_collection.insert(@book_address, @book)
    end

    describe '#get_book' do
      it 'return nil' do
        result = @empty_book_collection.get_book(@book_address)
        expect(result).to eq(nil)
      end

      it 'return book' do
        result = @book_collection.get_book(@book_address)
        expect(result).to eq(@book)
      end
    end

    describe '#empty?' do
      it 'return true' do
        result = @empty_book_collection.empty?
        expect(result).to eq(true)
      end

      it 'return false' do
        result = @book_collection.empty?
        expect(result).to eq(false)
      end
    end
  end

  describe '#insert' do
    it 'return success response' do
      book_collection = MyLibrary::BookCollection.new
      book_address = '010101'
      book = MyLibrary::Book.new({
                                   isbn: '1234567890123',
                                   author: 'J. K. Rowling',
                                   title: 'Harry Potter'
                                 })
      result = book_collection.insert(book_address, book)
      inserted_book = book_collection.get_book(book_address)
      expect(result).to eq(MyLibrary::Const.instance.response[:success])
      expect(inserted_book).to eq(book)
    end

    it 'return invalid book response' do
      book_collection = MyLibrary::BookCollection.new
      book_address = '010101'
      book = MyLibrary::Book.new({
                                   isbn: '123456789012',
                                   author: 'J. K. Rowling',
                                   title: 'Harry Potter'
                                 })
      result = book_collection.insert(book_address, book)
      inserted_book = book_collection.get_book(book_address)
      expect(result).to eq(MyLibrary::Const.instance.response[:invalid_book])
      expect(inserted_book).to eq(nil)
    end

    it 'return failed insert response due to not empty address' do
      book_collection = MyLibrary::BookCollection.new
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010101')
      book1 = MyLibrary::Book.new({
                                    isbn: '1234567890123',
                                    author: 'J. K. Rowling',
                                    title: 'Harry Potter'
                                  })
      book_collection.insert(book_address, book1)
      book2 = MyLibrary::Book.new({
                                    isbn: '1234567890124',
                                    author: 'J. K. Rowling',
                                    title: 'Harry Potter'
                                  })
      result = book_collection.insert(book_address, book2)
      inserted_book = book_collection.get_book(book_address)
      expect(result).to eq(MyLibrary::Const.instance.response[:failed])
      expect(inserted_book).to eq(book1)
    end

    it 'return already_exist response due to not same book' do
      book_collection = MyLibrary::BookCollection.new
      book_address1 = MyLibrary::BookAddress.new.string_to_book_address('010101')
      book1 = MyLibrary::Book.new({
                                    isbn: '1234567890123',
                                    author: 'J. K. Rowling',
                                    title: 'Harry Potter'
                                  })
      book_collection.insert(book_address1, book1)
      book_address2 = MyLibrary::BookAddress.new.string_to_book_address('010102')
      book2 = MyLibrary::Book.new({
                                    isbn: '1234567890123',
                                    author: 'J. K. Rowling',
                                    title: 'Harry Potter'
                                  })
      result = book_collection.insert(book_address2, book2)
      inserted_book = book_collection.get_book(book_address2)
      expect(result).to eq(MyLibrary::Const.instance.response[:already_exist])
      expect(inserted_book).to eq(nil)
    end
  end

  context 'when library is not empty' do
    before(:all) do
      @book_collection = MyLibrary::BookCollection.new
      @books = [
        MyLibrary::Book.new({
                              isbn: '1234567890123',
                              author: 'J. K. Rowling',
                              title: 'Harry Potter'
                            }),
        MyLibrary::Book.new({
                              isbn: '1234567890124',
                              author: 'Robert Cecil Martin',
                              title: 'Clean Code'
                            })
      ]
      @book_collection.insert('010101', @books[0])
      @book_collection.insert('010102', @books[1])
    end

    describe '#delete' do
      it 'return success response' do
        book_address = '010101'
        result = @book_collection.delete(book_address)
        deleted_book = @book_collection.get_book(book_address)
        expect(result).to eq(MyLibrary::Const.instance.response[:success])
        expect(deleted_book).to eq(nil)
      end

      it 'return failed response because the address has no book' do
        book_address = '010103'
        result = @book_collection.delete(book_address)
        expect(result).to eq(MyLibrary::Const.instance.response[:failed])
      end
    end

    describe '#empty_address?' do
      it 'return false when address is 010102' do
        result = @book_collection.empty_address?('010102')
        expect(result).to eq(false)
      end

      it 'return true when address is 020101' do
        result = @book_collection.empty_address?('020101')
        expect(result).to eq(true)
      end
    end
  end

  describe '#to_s' do
    it 'return empty string' do
      book_collection = MyLibrary::BookCollection.new
      result = book_collection.to_s
      expect(result).to eq('')
    end

    it 'return string of one book' do
      book_collection = MyLibrary::BookCollection.new
      book_address = '010101'
      book = MyLibrary::Book.new({
                                   isbn: '1234567890123',
                                   author: 'J. K. Rowling',
                                   title: 'Harry Potter'
                                 })
      book_collection.insert(book_address, book)
      result = book_collection.to_s
      expect(result).to eq('010101: 1234567890123 | Harry Potter | J. K. Rowling')
    end

    it 'return string of more than one book' do
      book_collection = MyLibrary::BookCollection.new
      book_address1 = '010101'
      book_address2 = '010102'
      book1 = MyLibrary::Book.new({
                                    isbn: '1234567890123',
                                    author: 'J. K. Rowling',
                                    title: 'Harry Potter'
                                  })
      book2 = MyLibrary::Book.new({
                                    isbn: '1234567890124',
                                    author: 'J. K. Rowling',
                                    title: 'Harry Potter'
                                  })
      book_collection.insert(book_address1, book1)
      book_collection.insert(book_address2, book2)
      result = book_collection.to_s
      expected = "010101: 1234567890123 | Harry Potter | J. K. Rowling\n010102: 1234567890124 | Harry Potter | J. K. Rowling"
      expect(result).to eq(expected)
    end
  end

  context 'when book collection consist of many books' do
    before(:all) do
      @book_collection = MyLibrary::BookCollection.new
      @books = [
        MyLibrary::Book.new({
                              isbn: '1234567890123',
                              author: 'J. K. Rowling',
                              title: 'Harry Potter'
                            }),
        MyLibrary::Book.new({
                              isbn: '1234567890124',
                              author: 'Robert Cecil Martin',
                              title: 'Clean Code'
                            }),
        MyLibrary::Book.new({
                              isbn: '1234567890125',
                              author: 'Robert Cecil Martin',
                              title: 'Clean Code'
                            })
      ]
      @book_collection.insert('010101', @books[0])
      @book_collection.insert('010102', @books[1])
    end

    describe '#==' do
      it 'return true' do
        another_book_collection = MyLibrary::BookCollection.new
        another_book_collection.insert('010101', @books[0])
        another_book_collection.insert('010102', @books[1])
        result = @book_collection == another_book_collection
        expect(result).to eq(true)
      end

      it 'return false when different address' do
        another_book_collection = MyLibrary::BookCollection.new
        another_book_collection.insert('010101', @books[0])
        another_book_collection.insert('010103', @books[1])
        result = @book_collection == another_book_collection
        expect(result).to eq(false)
      end

      it 'return false when different books' do
        another_book_collection = MyLibrary::BookCollection.new
        another_book_collection.insert('010101', @books[1])
        another_book_collection.insert('010102', @books[0])
        result = @book_collection == another_book_collection
        expect(result).to eq(false)
      end
    end

    describe '#find_book' do
      it 'return empty for isbn 1234567890125 not existed in the collection' do
        result = @book_collection.find_book('1234567890125')
        expect(result).to eq(nil)
      end

      it 'return 010102 for book with isbn 1234567890124' do
        result = @book_collection.find_book('1234567890124')
        expect(result).to eq('010102')
      end
    end

    describe '.search_book_by_title' do
      it 'return empty MyLibrary::BookCollection' do
        expected = MyLibrary::BookCollection.new
        result = MyLibrary::BookCollection.search_book_by_title(@book_collection, 'ruby')
        expect(result).to eq(expected)
      end

      it 'return a MyLibrary::BookCollection consist of a book' do
        expected = MyLibrary::BookCollection.new
        expected.insert('010102', @books[1])
        result = MyLibrary::BookCollection.search_book_by_title(@book_collection, 'code')
        expect(result).to eq(expected)
      end
    end

    describe '.search_book_by_author' do
      it 'return empty MyLibrary::BookCollection' do
        expected = MyLibrary::BookCollection.new
        result = MyLibrary::BookCollection.search_book_by_author(@book_collection, 'ruby')
        expect(result).to eq(expected)
      end

      it 'return a MyLibrary::BookCollection consist of a book' do
        expected = MyLibrary::BookCollection.new
        expected.insert('010102', @books[1])
        result = MyLibrary::BookCollection.search_book_by_author(@book_collection, 'rob')
        expect(result).to eq(expected)
      end
    end
  end
end
