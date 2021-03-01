require '../class/commands/build_library_command.rb'

RSpec.describe 'BuildLibraryCommand' do
  describe '#args_valid?' do
    it 'return true when args consist of three args' do
      command = BuildLibraryCommand.new
      args = [2, 1, 3]
      expect(command.args_valid?(args)).to eq(true)
    end
  end

  describe '#execute' do
    it 'stub Library#reset_size' do
      command = BuildLibraryCommand.new
      args = [2, 1, 3]
      params = {
        shelf_size: 2,
        row_size: 1,
        column_size: 3
      }
      expect_any_instance_of(Library).to receive(:reset_size).with(params)
      command.execute(args)
    end
  end
end