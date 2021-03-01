require '../class/commands/find_book_command.rb'
require '../class/library.rb'

RSpec.describe 'FindBookCommand' do
  it 'stub Library#find_book' do
    command = FindBookCommand.new
    args = ['9780807281918']
    expect_any_instance_of(Library).to receive(:find_book)
    command.execute(args)
  end
end