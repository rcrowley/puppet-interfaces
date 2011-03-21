require 'puppet/application/indirection_base'

class Puppet::Application::Certificate < Puppet::Application::IndirectionBase

  # Luke used to call this --ca but that's taken by the global boolean --ca.
  # Since these options map CA terminology to indirector terminology, it's
  # now called --ca-location.
  option "--ca-location CA_LOCATION" do |arg|
    Puppet::SSL::Host.ca_location = arg.to_sym
  end

  # The certificate application brings up a chicken-and-egg problem that
  # manifests itself as an infinite recursion: to request certificates via
  # the REST terminus, certificates must be requested to establish a
  # connection to the master.  This preloads locally cached certificates
  # before setting the certificate terminus in IndirectionBase#setup.
  def setup
    Puppet::SSL::Host.localhost
    super
  end

end
