# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::SearchBooksByAuthorCommand do
  describe '#args_valid?' do
    it 'return true when argument consist of one arguments' do
      command = MyLibrary::SearchBooksByAuthorCommand.new
      args = ['Kent Beck']
      expect(command.args_valid?(args)).to eq(true)
    end

    it 'return false when argument consist of two arguments' do
      command = MyLibrary::SearchBooksByAuthorCommand.new
      args = ['Kent Beck', 'another param']
      expect(command.args_valid?(args)).to eq(false)
    end
  end

  describe '#execute' do
    it 'stub Library#search_book_by_author' do
      command = MyLibrary::SearchBooksByAuthorCommand.new
      args = ['Kent Beck']
      expect_any_instance_of(MyLibrary::Library).to receive(:search_book_by_author).with(args[0])
      command.execute(args)
    end
  end
end
