# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::Library do
  describe '#valid?' do
    it 'return false when params is nil' do
      result = MyLibrary::Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return true when shelf_size 3, row_size 2, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
      MyLibrary::Library.instance.reset_size(params)
      result = MyLibrary::Library.instance.valid?
      expect(result).to eq(true)
    end

    it 'return false when shelf_size 0, row_size 2, column_size 2' do
      params = {
        shelf_size: 0,
        row_size: 2,
        column_size: 2
      }
      MyLibrary::Library.instance.reset_size(params)
      result = MyLibrary::Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 100, row_size 2, column_size 2' do
      params = {
        shelf_size: 100,
        row_size: 2,
        column_size: 2
      }
      MyLibrary::Library.instance.reset_size(params)
      result = MyLibrary::Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 0, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 0,
        column_size: 2
      }
      MyLibrary::Library.instance.reset_size(params)
      result = MyLibrary::Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 100, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 100,
        column_size: 2
      }
      MyLibrary::Library.instance.reset_size(params)
      result = MyLibrary::Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 2, column_size 0' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 0
      }
      MyLibrary::Library.instance.reset_size(params)
      result = MyLibrary::Library.instance.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 2, column_size 100' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 100
      }
      MyLibrary::Library.instance.reset_size(params)
      result = MyLibrary::Library.instance.valid?
      expect(result).to eq(false)
    end
  end

  describe '#find_next_empty_position' do
    before(:all) do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 3
      }
      MyLibrary::Library.instance.reset_size(params)
    end

    it 'return 010102 when empty MyLibrary::library' do
      result = MyLibrary::Library.instance.find_next_empty_position
      expected = MyLibrary::BookAddress.new.string_to_book_address('010102')
      expect(result).to eq(expected)
    end

    it 'return 010103 when schema quite complex' do
      MyLibrary::Library.instance.put_book({
                                             isbn: '1234567890123',
                                             author: 'J. K. Rowling',
                                             title: 'Harry Potter'
                                           })
      MyLibrary::Library.instance.put_book({
                                             isbn: '1234567890124',
                                             author: 'J. K. Rowling',
                                             title: 'Harry Potter'
                                           })
      MyLibrary::Library.instance.take_book_from('010101')
      result = MyLibrary::Library.instance.find_next_empty_position
      expected = MyLibrary::BookAddress.new.string_to_book_address('010103')
      expect(result).to eq(expected)
    end
  end

  context 'MyLibrary::library initialize with shelf_size 1, row_size 1, column_size 1' do
    before(:each) do
      MyLibrary::Library.instance.reset_size({
                                               shelf_size: 1,
                                               row_size: 1,
                                               column_size: 1
                                             })
    end

    describe '#full?' do
      it 'return false when initialization of valid empty MyLibrary::library' do
        result = MyLibrary::Library.instance.full?
        expect(result).to eq(false)
      end

      it 'return true' do
        MyLibrary::Library.instance.put_book({
                                               isbn: '1234567890123',
                                               author: 'J. K. Rowling',
                                               title: 'Harry Potter'
                                             })
        result = MyLibrary::Library.instance.full?
        expect(result).to eq(true)
      end
    end

    describe '#put_book' do
      it 'return success response' do
        result = MyLibrary::Library.instance.put_book({
                                                        isbn: '1234567890123',
                                                        author: 'J. K. Rowling',
                                                        title: 'Harry Potter'
                                                      })
        expect(result).to eq(MyLibrary::Const.instance.response[:success])
      end

      it 'return full response' do
        MyLibrary::Library.instance.put_book({
                                               isbn: '1234567890123',
                                               author: 'J. K. Rowling',
                                               title: 'Harry Potter'
                                             })
        result = MyLibrary::Library.instance.put_book({
                                                        isbn: '1234567890124',
                                                        author: 'J. K. Rowling',
                                                        title: 'Harry Potter'
                                                      })
        expect(result).to eq(MyLibrary::Const.instance.response[:full])
      end

      it 'return already_exist response' do
        MyLibrary::Library.instance.reset_size({
                                                 shelf_size: 1,
                                                 row_size: 1,
                                                 column_size: 2
                                               })
        MyLibrary::Library.instance.put_book({
                                               isbn: '1234567890123',
                                               author: 'J. K. Rowling',
                                               title: 'Harry Potter'
                                             })
        result = MyLibrary::Library.instance.put_book({
                                                        isbn: '1234567890123',
                                                        author: 'J. K. Rowling',
                                                        title: 'Harry Potter'
                                                      })
        expect(result).to eq(MyLibrary::Const.instance.response[:already_exist])
      end

      it 'return invalid book response' do
        result = MyLibrary::Library.instance.put_book({
                                                        isbn: '12345678901',
                                                        author: 'J. K. Rowling',
                                                        title: 'Harry Potter'
                                                      })
        expect(result).to eq(MyLibrary::Const.instance.response[:invalid_book])
      end
    end

    describe '#take_book_from' do
      it 'return invalid address' do
        result = MyLibrary::Library.instance.take_book_from('010201')
        expect(result).to eq(MyLibrary::Const.instance.response[:invalid_address])
      end

      it 'return failed address due to empty MyLibrary::library' do
        result = MyLibrary::Library.instance.take_book_from('010101')
        expect(result).to eq(MyLibrary::Const.instance.response[:failed])
      end

      it 'return success response' do
        MyLibrary::Library.instance.put_book({
                                               isbn: '1234567890123',
                                               author: 'J. K. Rowling',
                                               title: 'Harry Potter'
                                             })
        result = MyLibrary::Library.instance.take_book_from('010101')
        expect(result).to eq(MyLibrary::Const.instance.response[:success])
      end
    end
  end

  context 'MyLibrary::library initialize with shelf_size 1, row_size 3, column_size 2' do
    before(:all) do
      MyLibrary::Library.instance.reset_size({
                                               shelf_size: 2,
                                               row_size: 1,
                                               column_size: 3
                                             })
      MyLibrary::Library.instance.put_book({
                                             isbn: '9780747532743',
                                             author: 'J. K. Rowling',
                                             title: 'Harry Potter 1'
                                           })
      MyLibrary::Library.instance.put_book({
                                             isbn: '9780807281918',
                                             author: 'J. K. Rowling',
                                             title: 'Harry Potter 2'
                                           })
      MyLibrary::Library.instance.put_book({
                                             isbn: '9780739330944',
                                             author: 'Christopher Paolini',
                                             title: 'Eragon 1'
                                           })
      MyLibrary::Library.instance.put_book({
                                             isbn: '9780545582933',
                                             author: 'J. K. Rowling',
                                             title: 'Harry Potter 3'
                                           })
      MyLibrary::Library.instance.put_book({
                                             isbn: '9780132350884',
                                             author: 'Robert Cecil Martin',
                                             title: 'Clean Code'
                                           })
      MyLibrary::Library.instance.put_book({
                                             isbn: '9780201485677',
                                             author: 'Martin Fowler, Kent Beck',
                                             title: 'Refactoring'
                                           })
    end

    describe '#find_book' do
      it 'return book found when find 9780807281918' do
        result = MyLibrary::Library.instance.find_book('9780807281918')
        expect(result).to eq(MyLibrary::Const.instance.response[:found])
      end

      it 'return book found when find 000' do
        result = MyLibrary::Library.instance.find_book('000')
        expect(result).to eq(MyLibrary::Const.instance.response[:not_found])
      end
    end

    describe '#search_book_by_author' do
      it 'return book found when find Kent Beck' do
        result = MyLibrary::Library.instance.search_book_by_author('Kent Beck')
        expect(result).to eq(MyLibrary::Const.instance.response[:found])
      end

      it 'return book found when find Tolkien' do
        result = MyLibrary::Library.instance.search_book_by_author('Tolkien')
        expect(result).to eq(MyLibrary::Const.instance.response[:not_found])
      end
    end

    describe '#search_book_by_title' do
      it 'return book found when find Harry Potter' do
        result = MyLibrary::Library.instance.search_book_by_title('Harry Potter')
        expect(result).to eq(MyLibrary::Const.instance.response[:found])
      end

      it 'return book found when find Tolkien' do
        result = MyLibrary::Library.instance.search_book_by_title('Little Prince')
        expect(result).to eq(MyLibrary::Const.instance.response[:not_found])
      end
    end

    describe '#list_books' do
      it 'return calls the list_books function' do
        expect_any_instance_of(MyLibrary::BookCollection).to receive(:to_s)
        MyLibrary::Library.instance.list_books
      end
    end

    describe '#take_book_from' do
      it 'return success response and change the available position value' do
        result = MyLibrary::Library.instance.take_book_from('010102')
        expect(result).to eq(MyLibrary::Const.instance.response[:success])
      end
    end
  end

  context 'when MyLibrary::Library is uninitialize' do
    before(:all) do
      MyLibrary::Library.instance.reset_size() 
    end

    describe '#take_book_from' do
      it 'raise StandardError of invalid Library' do
        expect { MyLibrary::Library.instance.take_book_from('010102') }.to raise_error(StandardError)
      end
    end

    describe '#find_book' do
      it 'raise StandardError of invalid Library' do
        expect { MyLibrary::Library.instance.find_book('9780807281918') }.to raise_error(StandardError)
      end
    end

    describe '#list_books' do
      it 'raise StandardError of invalid Library' do
        expect { MyLibrary::Library.instance.list_books }.to raise_error(StandardError)
      end
    end

    describe '#search_book_by_author' do
      it 'raise StandardError of invalid Library' do
        expect { MyLibrary::Library.instance.search_book_by_author('Kent Beck') }.to raise_error(StandardError)
      end
    end
  end
end
