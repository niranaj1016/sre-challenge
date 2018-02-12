#
# Cookbook:: sre-challenge
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'slm-test::default' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge('sre-challenge::default')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end

