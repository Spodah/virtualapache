class portforward {
	package{'apache2':
		ensure =>installed,
		allowcdrom =>true,
	}
	file{'/etc/apache2/ports.conf':
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
	exec{"sudo a2enmod proxy":
		path => "/bin/:/usr/bin/:/sbin/:/usr/sbin/",
		require =>Package['apache2'],
		notify =>Service['apache2'],
	}
	exec{"sudo a2enmod proxy_http":
		path => "/bin/:/usr/bin/:/sbin/:/usr/sbin/",
                require =>Package['apache2'],
                notify =>Service['apache2'],
	}
}
