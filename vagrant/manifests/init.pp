class vagrant {
	package{'virtualbox':
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
	}
	file{'/home/juuso/manifests':
		ensure =>directory,
	}
	file{'/home/juuso/manifests/default.pp':
		content =>template('vagrant/default.pp.erb'),
	}
}
