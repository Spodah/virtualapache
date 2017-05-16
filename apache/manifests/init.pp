class apache {
	package{'apache2':
		ensure =>installed,
		allowcdrom =>true
	}
	file{'/etc/apache2/sites-available/example.com.conf':
		content =>template('apache/example.com.conf.erb'),
		notify =>Service['apache2'],
		require =>Package['apache2'],
	}
	file{'/etc/apache2/sites-available/000-default.conf':
		backup =>true,
		ensure =>absent,
                require =>Package['apache2'],
	}
	file{'/etc/apache2/sites-enabled/example.com.conf':
		content =>template('apache/se-example.com.conf.erb'),
		notify =>Service['apache2'],
                require =>Package['apache2'],
	}
	file{'/etc/apache2/sites-enabled/000-default.conf':
		backup =>true,
		ensure =>absent,
                require =>Package['apache2'],
	}
	file{'/etc/apache2/apache2.conf':
		content =>template('apache/apache2.conf.erb'),
		notify =>Service['apache2'],
                require =>Package['apache2'],
	}
	file{'/home/juuso/example':
		ensure =>directory,
	}
	file{'/home/juuso/example/index.html':
		content =>template('apache/index.html.erb'),
	}
	service{'apache2':
		ensure =>true,
		enable =>true,
                require =>Package['apache2'],
		provider =>systemd,
	}
}
