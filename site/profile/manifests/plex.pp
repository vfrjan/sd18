class  profile::plex (
 $swurl = 'https://s3.eu-central-1.amazonaws.com/vfrjanstest/plexmediaserver-1.10.1.4602-f54242b6b.x86_64.rpm',
){
 
    package {'plexmediaserver':
      provider => rpm,
      source   => $swurl,
      ensure   => installed,
      before   =>  [Service['plexmediaserver']],
#   require  => [File["${install_dir}/lms.rpm"]],
    }

    service {'plexmediaserver':
      ensure => running,
      enable => true,
    }
}
