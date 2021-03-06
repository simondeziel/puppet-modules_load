#
# Define: kernel::modprobe::blacklist
#
# Deploy module blacklists in /etc/modprobe.d/
#
# Simple usage:
# kernel::modprobe::blacklist { 'dccp':
#  comment => "CVE-2017-6074",
# }
#
#
define kernel::modprobe::blacklist (
  Enum['present','absent'] $ensure = 'present',
  Optional[String] $comment        = undef,
) {
  $content = $comment ? {
    undef   => "# File managed by Puppet\ninstall ${name} /bin/true\n",
    default => "# File managed by Puppet\n# ${comment}\ninstall ${name} /bin/true\n"
  }

  kernel::modprobe::conf { "blacklist-${name}":
    ensure  => $ensure,
    content => $content,
  }
}
