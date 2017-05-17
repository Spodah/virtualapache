##init.pp

#exec{"bash /home/kubuntu/virtualapache/vbox.sh"
Installing virtualbox from default repositories doesn't work with live USB, this workaround adds repository to fix that. Should be changed to only run when necessary

#file{'/home/kubuntu/Vagrantfile':
Enables on the virtualmachine networking, installs puppet and uses default.pp to determine which puppet modules to install.

#package apache, service apache, exec aeonmod, ports.config
Required to configure virtualmachine to port 80, otherwise virtualbox would have to be run as root
