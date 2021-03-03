# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::PutBookCommand do
  describe '#args_valid?' do
    it 'return true when args consist of three arguments' do
      command = MyLibrary::PutBookCommand.new
      args = ['9780747532743', 'Harry Potter 1', 'J. K. Rowling']
      expect(command.args_valid?(args)).to eq(true)
    end

    it 'return false when args consist of two arguments' do
      command = MyLibrary::PutBookCommand.new
      args = ['9780747532743', 'Harry Potter 1']
      expect(command.args_valid?(args)).to eq(false)
    end
  end

  describe '#execute' do
    it 'stub Library#put_book' do
      command = MyLibrary::PutBookCommand.new
      args = ['9780747532743', 'Harry Potter 1', 'J. K. Rowling']
      params = {
        isbn: args[0],
        title: args[1],
        author: args[2]
      }
      expect_any_instance_of(MyLibrary::Library).to receive(:put_book).with(params)
      command.execute(args)
    end
  end
end
