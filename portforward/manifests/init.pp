class portforward {
	package{'apache2':
		ensure =>installed,
		allowcdrom =>true,
	}
	file{'/etc/apache/ports.conf':
		content =>template('portforward/ports.conf.erb'),
		notify =>Service['apache2'],
		require =>Package['apache2'],
	}
	service{'apache2':
		ensure =>true,
		enable =>true,
		require =>Package['apache2'],
		provider =>systemd,
	}
}
