maintainer       "NREL"
maintainer_email "nick.muerdter@nrel.gov"
license          "All rights reserved"
description      "Installs/Configures mongodb"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.2"

depends "cron"
depends "iptables"
depends "yum"
