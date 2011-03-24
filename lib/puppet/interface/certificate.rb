require 'puppet/interface/indirector'
require 'puppet/ssl/host'

Puppet::Interface::Indirector.interface(:certificate) do

  action :clean do
    invoke do |name|
      Puppet::SSL::Host.indirection.destroy(Puppet::SSL::Host.new(name))
    end
  end

  action :list do
    invoke do
      Puppet::SSL::Host.indirection.search("*")
    end
  end

end
