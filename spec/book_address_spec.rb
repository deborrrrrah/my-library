# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::BookAddress do
  describe '#to_s' do
    it 'return 010101' do
      book_address = MyLibrary::BookAddress.new({
                                                  shelf: 1,
                                                  row: 1,
                                                  column: 1
                                                })
      result = book_address.to_s
      expect(result).to eq('010101')
    end

    it 'return 100101' do
      book_address = MyLibrary::BookAddress.new({
                                                  shelf: 10,
                                                  row: 1,
                                                  column: 1
                                                })
      result = book_address.to_s
      expect(result).to eq('100101')
    end
  end

  describe '#==' do
    it 'return true of the exact same address attributes' do
      book_address1 = MyLibrary::BookAddress.new({
                                                   shelf: 1,
                                                   row: 1,
                                                   column: 1
                                                 })
      book_address2 = MyLibrary::BookAddress.new({
                                                   shelf: 1,
                                                   row: 1,
                                                   column: 1
                                                 })
      result = book_address1 == book_address2
      expect(result).to eq(true)
    end

    it 'return false of the different address attributes' do
      book_address1 = MyLibrary::BookAddress.new({
                                                   shelf: 1,
                                                   row: 1,
                                                   column: 1
                                                 })
      book_address2 = MyLibrary::BookAddress.new({
                                                   shelf: 2,
                                                   row: 1,
                                                   column: 1
                                                 })
      result = book_address1 == book_address2
      expect(result).to eq(false)
    end
  end

  describe '#string_to_book_address' do
    it 'return right book address when set 010101' do
      book_address = MyLibrary::BookAddress.new({
                                                  shelf: 1,
                                                  row: 1,
                                                  column: 1
                                                })
      result = MyLibrary::BookAddress.new.string_to_book_address('010101')
      expect(result).to eq(book_address)
    end

    it 'return right book address when set 100101' do
      book_address = MyLibrary::BookAddress.new({
                                                  shelf: 10,
                                                  row: 1,
                                                  column: 1
                                                })
      result = MyLibrary::BookAddress.new.string_to_book_address('100101')
      expect(result).to eq(book_address)
    end

    it 'return right book address when set 999999' do
      book_address = MyLibrary::BookAddress.new({
                                                  shelf: 99,
                                                  row: 99,
                                                  column: 99
                                                })
      result = MyLibrary::BookAddress.new.string_to_book_address('999999')
      expect(result).to eq(book_address)
    end

    it 'return nil when set 0101010' do
      result = MyLibrary::BookAddress.new.string_to_book_address('0101010')
      expect(result).to eq(nil)
    end

    it 'raise ArgumentError when set 01aa01' do
      expect { MyLibrary::BookAddress.new.string_to_book_address('01aa01') }.to raise_error(ArgumentError)
    end
  end

  describe '#valid?' do
    it 'return true for position 010101' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010101')
      result = book_address.valid?
      expect(result).to eq(true)
    end

    it 'return false for shelf -1, row 1, column 1' do
      book_address = MyLibrary::BookAddress.new({
                                                  shelf: -1,
                                                  row: 1,
                                                  column: 1
                                                })
      result = book_address.valid?
      expect(result).to eq(false)
    end

    it 'return false for nil attributes' do
      book_address = MyLibrary::BookAddress.new
      result = book_address.valid?
      expect(result).to eq(false)
    end

    it 'return false for position 010001' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010001')
      result = book_address.valid?
      expect(result).to eq(false)
    end

    it 'return false for position 010100' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010100')
      result = book_address.valid?
      expect(result).to eq(false)
    end

    it 'return false for shelf 1, row 100, column 1' do
      book_address = MyLibrary::BookAddress.new({
                                                  shelf: 1,
                                                  row: 100,
                                                  column: 1
                                                })
      result = book_address.valid?
      expect(result).to eq(false)
    end
  end

  describe '#next_address' do
    before(:all) do
      @size_limit = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
    end
    it 'return 010102 when current is 010101' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010101')
      result = book_address.next_address(@size_limit)
      expected_address = MyLibrary::BookAddress.new.string_to_book_address('010102')
      expect(result).to eq(expected_address)
    end

    it 'return 010201 when current is 010102' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010102')
      result = book_address.next_address(@size_limit)
      expected_address = MyLibrary::BookAddress.new.string_to_book_address('010201')
      expect(result).to eq(expected_address)
    end

    it 'return 020101 when current is 010202' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010202')
      result = book_address.next_address(@size_limit)
      expected_address = MyLibrary::BookAddress.new.string_to_book_address('020101')
      expect(result).to eq(expected_address)
    end

    it 'return nil when current is 030202' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('030202')
      result = book_address.next_address(@size_limit)
      expect(result).to eq(nil)
    end
  end

  describe '#shelf_in_range?' do
    it 'return true for position 010101 with max_size 3 and min_size 0' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010101')
      min_size = 0
      max_size = 3
      result = book_address.shelf_in_range?(min_size, max_size)
      expect(result).to eq(true)
    end

    it 'return false for position 010101 with max_size 3 and min_size 1' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010101')
      min_size = 1
      max_size = 3
      result = book_address.shelf_in_range?(min_size, max_size)
      expect(result).to eq(false)
    end
  end

  describe '#row_in_range?' do
    it 'return true for position 010101 with max_size 3 and min_size 0' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010101')
      min_size = 0
      max_size = 3
      result = book_address.row_in_range?(min_size, max_size)
      expect(result).to eq(true)
    end

    it 'return false for position 020101 with max_size 3 and min_size 1' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('020101')
      min_size = 1
      max_size = 3
      result = book_address.row_in_range?(min_size, max_size)
      expect(result).to eq(false)
    end
  end

  describe '#column_in_range?' do
    it 'return true for position 010101 with max_size 3 and min_size 0' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('010101')
      min_size = 0
      max_size = 3
      result = book_address.column_in_range?(min_size, max_size)
      expect(result).to eq(true)
    end

    it 'return false for position 020201 with max_size 3 and min_size 1' do
      book_address = MyLibrary::BookAddress.new.string_to_book_address('020201')
      min_size = 1
      max_size = 3
      result = book_address.column_in_range?(min_size, max_size)
      expect(result).to eq(false)
    end
  end
end
