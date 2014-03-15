# LAMP Server for grok

This repository contains vagrant and puppet scripts to setup a LAMP server.

## Requirements

- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
- Download and install [Vagrant](http://www.vagrantup.com/downloads.html).
- Download [quantal64 Vagrant box file](https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box).

## Box Setup

First, you will need to import the box file into vagrant. Use the following command:

```
vagrant box add quantal64 /path/to/quantal64.box
```

Next, clone this repo, and `cd` into the new directory. Then, you can use the following command:

```
vagrant up
```

Within a few minutes, you will have a complete LAMP server running in a VM (virtual machine). While the VM is being initialized, go ahead and add the following entry to the hosts file on the host computer (not the VM):

```
192.168.77.77    grok.dev
```

A default apache virtual host gets created during the install and this is the domain that is used.  

## Installation Verification

To make sure that your LAMP server is working properly, browse to:

[http://localhost:8080](http://localhost:8080)

If you see a success page, you know things are working.

## Other Vagrant Commands

If you'd like to stop the VM, use the following command: `vagrant halt`. You can also destroy the VM by using: `vagrant destroy`. At any time, you can just issue: `vagrant up` to start running or re-create the VM.

If you'd like to access the console of the VM directly, use: `vagrant ssh`.

## VM Credentials

- root password: vagrant
- default user: vagrant
- vagrant user password: vagrant
- mysql root password: root

## Authoring Sites

An example site, grok.dev, is included in the /sites directory of this repo. You can edit files here directly in your host OS, and the changes will be automatically reflected in the VM. To add additional sites, perform the following steps:

- Create a new directory within /sites, using the format: `domain.dev`, and add site files in a public directory inside the directory you just created.
- SSH into the VM: `vagrant ssh`
- Access the sites-available directory: `cd /etc/apache2/sites-available`
- Copy the sample virtual host file: `sudo cp grok.dev domain.dev`
- Edit the copied file: `sudo vim domain.dev`
- Locate all occurrences of grok and replace them with your new domain: `:%s/grok/domain/g`
- Save and close the file: `:wq`
- Enable your new site: `sudo a2ensite domain.dev`
- Restart Apache using: `sudo service apache2 reload`
- Add an entry to your host OS's hosts file: `192.168.77.77  domain.dev`
- All done! Now browse to: `http://domain.dev` to access your site.


## Accessing MySQL

In order to access MySQL via your host OS through a tool like SequelPro, you will need to connect via SSH using the credentials provided above.
