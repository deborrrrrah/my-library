require '../class/library.rb'

RSpec.describe 'Library' do
  describe '#valid?' do
    it 'return true when shelf_size 3, row_size 2, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(true)
    end

    it 'return false when shelf_size 0, row_size 2, column_size 2' do
      params = {
        shelf_size: 0,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end
  end
end