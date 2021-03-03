# frozen_string_literal: true

RSpec.describe MyLibrary do
  it 'has a version number' do
    expect(MyLibrary::VERSION).not_to be nil
  end
end
