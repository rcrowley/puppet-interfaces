require 'puppet/interface/indirector'
require 'puppet/ssl/certificate_request'

Puppet::Interface::Indirector.interface(:certificate_request) do

  action :generate do
    invoke do |name|
      host = Puppet::SSL::Host.new(name)
      host.generate_certificate_request
      host.certificate_request.class.indirection.save(host.certificate_request)
    end
  end

  action :list do
    invoke do
      Puppet::SSL::CertificateRequest.indirection.search("*")
    end
  end

  action :sign do
    invoke do |name|
      Puppet::SSL::Host.indirection.save(Puppet::SSL::Host.new(name))
    end
  end

end
