name             'cloudformation'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures cloudformation'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'
depends 'aws', '>=4.2.0'
depends 'infra', '>=1.0.0'
