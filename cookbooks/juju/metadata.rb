name             'juju'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures juju'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


depends "rightscale"
depends "apt"

recipe "juju::default", "installs and configures juju"
recipe "juju::deploy", "installs juju charms"

attribute "juju/access_key_id", 
  :display_name => "Access Key ID",
  :description => "access_key_id"

attribute "juju/secret_access_key",
  :display_name => "Secret Access Key",
  :description => "Secret Access Key"

attribute "juju/charms",
  :display_name => "Juju Charms",
  :description => "Comma separated list of juju charms to install",
  :recipes => ["juju::deploy"]
