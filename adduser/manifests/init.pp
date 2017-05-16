class adduser{
	user{'juuso':
		name => juuso,
		ensure => present,
		home => '/home/juuso',
		managehome => true,
	}
}
