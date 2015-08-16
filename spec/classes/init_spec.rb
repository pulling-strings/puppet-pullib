require 'spec_helper'
describe 'pullib' do

  context 'with defaults for all parameters' do
    it { should contain_class('pullib') }
  end
end
