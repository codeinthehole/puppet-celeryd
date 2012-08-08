class celeryd::base {
	user { "celery": 
		ensure => present
	}
	file { "/var/log/celeryd": 
	    ensure => directory,
		owner => "celery",
		require => User["celery"],
	}
	file { "/var/run/celeryd": 
	    ensure => directory,
		owner => "celery",
		require => User["celery"],
	}
}

define celeryd::service (
	$conf_path,
	$environment='vagrant') {
	file { "/etc/init.d/celeryd-$environment": 
	    ensure => present,
		mode => "0755",
		content => template("celeryd/init.d.sh.erb"),
		require => Class["celeryd::base"],
	}
	service { "celeryd-$environment":
	    ensure => "running",
		require => File["/etc/init.d/celeryd-$environment"],
	}
}

class celeryd {
	include celeryd::base
}