class vagrant {
	package{'virtualbox-5.1':
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
	file{'/home/juuso/Vagrantfile':
		content =>template('vagrant/Vagrantfile.erb'),
		owner =>juuso,
	}
	file{'/home/juuso/manifests':
		ensure =>directory,
		owner =>juuso,
	}
	file{'/home/juuso/manifests/default.pp':
		content =>template('vagrant/default.pp.erb'),
		owner =>juuso,
	}
	file{'/etc/apt/sources.list':
		content =>template('vagrant/sources.list.erb'),
		notify =>Exec["bash /home/kubuntu/virtualapache/vbox.sh"],
	}
	exec{"bash /home/kubuntu/virtualapache/vbox.sh":
		path => "/bin/:/usr/bin/:/sbin/:/usr/sbin/",
		notify =>Package['virtualbox-5.1'],
	}
}
