# frozen_string_literal: true

RSpec.describe Msgpack::Rpc::Gateway do
  it 'has a version number' do
    expect(Msgpack::Rpc::Gateway::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
