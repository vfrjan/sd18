class  lms (
 $swurl = 'http://downloads.slimdevices.com/nightly/7.9/sc/a853101/logitechmediaserver-7.9.1-0.1.1517314665.noarch.rpm'
 $cfgurl = 'https://s3.eu-central-1.amazonaws.com/vfrjanstest/server.prefs'
 $install_dir = '/root/Downloads'
  
){
 
    file {"${install_dir}"
      ensure => directory,
    }
   file {"${install_dir}/lms.rpm":
       ensure => file,
       source => $swurl,
       before => Service['squeezeboxserver'],
    }
    file {'/usr/lib64/perl5/Slim':
      ensure => link,
      target => '/usr/lib/perl5/vendor_perl/Slim',
      before => Service['squeezeboxserver'],
    }
    file {'/var/lib/squeezeboxserver/prefs/server.prefs':
      ensure => file,
      source => $cfgurl,
      before => Service['squeezeboxserver'],
    }

    package {'/root/Downloads/lms.rpm':
      ensure  => installed,
      before  =>  [Service['squeezeboxserver'],File['/usr/lib64/perl5/Slim'],File['/var/lib/squeezeboxserver/prefs/server.prefs']]
      require => [File["${install_dir}/lms.rpm"]]
    }

    service {'squeezeboxserver':
      ensure => running,
      enable = > true,
    }
}
