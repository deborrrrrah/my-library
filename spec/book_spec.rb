require '../class/book.rb'

RSpec.describe 'Book' do
  describe '#valid?' do
    it 'return false when empty strings as parameters' do
      book = Book.new({
        isbn: '',
        author: '',
        title: ''
      })
      result = book.valid?
      expect(result).to eq(false)
    end

    it 'return true when got valid parameters' do
      book = Book.new({
        isbn: '1234567890123',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      result = book.valid?
      expect(result).to eq(true)
    end

    it 'return false when isbn parameter is not 13-length string' do
      book = Book.new({
        isbn: '123456789012',
        author: 'J. K. Rowling',
        title: 'Harry Potter'
      })
      result = book.valid?
      expect(result).to eq(false)
    end
  end
end