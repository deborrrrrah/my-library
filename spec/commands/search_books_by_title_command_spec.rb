# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::SearchBooksByTitleCommand do
  describe '#args_valid?' do
    it 'return true when argument only consist of one element' do
      command = MyLibrary::SearchBooksByTitleCommand.new
      args = ['Harry Potter 1']
      expect(command.args_valid?(args)).to eq(true)
    end

    it 'return false when argument only consist of two element' do
      command = MyLibrary::SearchBooksByTitleCommand.new
      args = ['Harry Potter 1', 'another params']
      expect(command.args_valid?(args)).to eq(false)
    end
  end

  describe '#execute' do
    it 'stub Library#search_book_by_title' do
      command = MyLibrary::SearchBooksByTitleCommand.new
      args = ['Harry Potter 1']
      expect_any_instance_of(MyLibrary::Library).to receive(:search_book_by_title).with(args[0])
      command.execute(args)
    end
  end
end
