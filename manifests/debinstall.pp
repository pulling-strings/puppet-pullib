# Install Deb file from a url
define pullib::debinstall(
  $url,
  $deb,
  $ensure = latest,
  $dependencies = []
){

  exec{"download ${name} deb":
    command => "wget -P /usr/src/ ${url}/${deb}",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    unless  => "test -f /usr/src/${deb}"
  }
  
  if $dependencies != [] {
    package{$dependencies:
      ensure  => present
    } -> Package[$name]
  }

  package{$name:
    ensure   => latest,
    source   => "/usr/src/${deb}",
    provider => dpkg,
    require  => Exec["download ${name} deb"]
  }

}
