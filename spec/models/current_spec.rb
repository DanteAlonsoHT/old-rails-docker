require 'spec_helper'

describe Current do
  it 'stores admin_id in the thread' do
    Current.admin_id = 1
    expect(Current.admin_id).to eq(1)
  end

  it 'resets admin_id correctly' do
    Current.admin_id = 1
    Current.reset
    expect(Current.admin_id).to be_nil
  end
end
