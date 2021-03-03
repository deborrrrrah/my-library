# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::FindBookCommand do
  describe '#args_valid?' do
    it 'return true when only one args' do
      command = MyLibrary::FindBookCommand.new
      args = ['9780807281918']
      expect(command.args_valid?(args)).to eq(true)
    end

    it 'return false when the arguments consist of two args' do
      command = MyLibrary::FindBookCommand.new
      args = ['9780807281918', 'another params']
      expect(command.args_valid?(args)).to eq(false)
    end
  end

  describe '#execute' do
    it 'stub Library#find_book' do
      command = MyLibrary::FindBookCommand.new
      args = ['9780807281918']
      expect_any_instance_of(MyLibrary::Library).to receive(:find_book).with(args[0])
      command.execute(args)
    end
  end
end
