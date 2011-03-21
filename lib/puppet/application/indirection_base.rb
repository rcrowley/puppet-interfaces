require 'puppet/application/interface_base'

class Puppet::Application::IndirectionBase < Puppet::Application::InterfaceBase
  option("--terminus TERMINUS") do |arg|
    @terminus = arg
  end

  option("--stdin") do |arg|
    @stdin = true
  end

  attr_accessor :terminus, :indirection

  # Create an object from the serialization passed on standard input.
  # The object is passed via the arguments list into the eventual
  # Puppet::Indirector::Request.
  def main
    if @stdin
      arguments << interface.indirection.model.convert_from(format, STDIN.read)
    end
    super
  end

  def setup
    @stdin ||= false
    super

    if interface.respond_to?(:indirection)
      raise "Could not find data type #{type} for application #{self.class.name}" unless interface.indirection

      interface.set_terminus(terminus) if terminus
    end
  end
end
