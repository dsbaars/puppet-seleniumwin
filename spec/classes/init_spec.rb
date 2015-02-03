require 'spec_helper'
describe 'seleniumwin' do

  context 'with defaults for all parameters' do
    it { should contain_class('seleniumwin') }
  end
end
