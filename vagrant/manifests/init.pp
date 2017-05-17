class vagrant {
	package{'virtualbox-5.0':
		ensure =>installed,
		allowcdrom =>true
	}
	package{'vagrant':
		ensure =>installed,
		allowcdrom =>true
	}
	package{'puppetmaster':
		ensure =>installed,
		allowcdrom =>true
	}
	file{'/home/kubuntu/Vagrantfile':
		content =>template('vagrant/Vagrantfile.erb'),
		owner =>kubuntu,
	}
	file{'/home/kubuntu/manifests':
		ensure =>directory,
		owner =>kubuntu,
	}
	file{'/home/kubuntu/manifests/default.pp':
		content =>template('vagrant/default.pp.erb'),
		owner =>kubuntu,
	}
	file{'/etc/apt/sources.list':
		content =>template('vagrant/sources.list.erb'),
		notify =>Exec["bash /home/kubuntu/virtualapache/vbox.sh"],
	}
	exec{"bash /home/kubuntu/virtualapache/vbox.sh":
		path => "/bin/:/usr/bin/:/sbin/:/usr/sbin/",
		notify =>Package['virtualbox-5.0'],
	}
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
}}
