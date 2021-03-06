#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')
require 'puppet/interface/config'

describe Puppet::Interface.interface(:config) do
  it "should use Settings#print_config_options when asked to print" do
    Puppet.settings.stubs(:puts)
    Puppet.settings.expects(:print_config_options)
    subject.print
  end

  it "should set 'configprint' to all desired values and call print_config_options when a specific value is provided" do
    Puppet.settings.stubs(:puts)
    Puppet.settings.expects(:print_config_options)
    subject.print("libdir", "ssldir")
    Puppet.settings[:configprint].should == "libdir,ssldir"
  end
end
