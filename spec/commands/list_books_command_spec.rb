# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::ListBooksCommand do
  describe '#args_valid?' do
    it 'always return true' do
      command = MyLibrary::ListBooksCommand.new
      args = []
      expect(command.args_valid?(args)).to eq(true)
    end
  end

  describe '#execute' do
    it 'stub Library#list_books' do
      command = MyLibrary::ListBooksCommand.new
      expect_any_instance_of(MyLibrary::Library).to receive(:list_books)
      command.execute
    end
  end
end
