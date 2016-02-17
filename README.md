# Rubick

The official Ruby on Rails and Hanami local development environment.

## Introduction

Rubick is a pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install Ruby, Rails, Hanami, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Rubick runs on any Windows, Mac, or Linux system, and includes the Nginx web server, Ruby 2.2.4, Rails 4.2.5.1, Hanami 0.7.2, MySQL, Postgres, Redis, Memcached, Node and all of the other goodies you need to develop amazing Ruby applications.

> Note: If you are using Windows, you may need to enable hardware virtualization (VT-x). It can usually be
> enabled via your BIOS.

### Included Software

* Ubuntu 14.04
* Git
* Ruby 2.2.4
* Rails
* Hanami
* Nginx
* Passenger
* MySQL
* Sqlite3
* Postgres
* Node (With PM2, Bower, Grunt, and Gulp)
* Redis
* Memcached

## Installation & Setup

### First Steps

Before launching your Rubick environment, you must install [VirtualBox 5.x](https://www.virtualbox.org/wiki/Downloads) as well as [Vagrant](https://www.vagrantup.com/downloads.html). All of these software packages provide easy-to-use visual installers for all popular operating systems.

**Installing The Rubick Vagrant Box**

Once VirtualBox and Vagrant have been installed, you should add the `cuonggt/rubick` box to your Vagrant installation using the following command in your terminal. It will take a few minutes to download the box, depending on your Internet connection speed:

    vagrant box add cuonggt/rubick

If this command fails, make sure your Vagrant installation is up to date.

**Installing Rubick**

You may install Rubick by simply cloning the repository. Consider cloning the repository into a `Rubick` folder within your "home" directory, as the Rubick box will serve as the host to all of your Ruby projects:

    cd ~

    git clone https://github.com/cuonggt/rubick.git Rubick
    
Once you have cloned the Rubick repository, run the `bash init.sh` command from the Rubick directory to create the `Rubick.yaml` configuration file. The `Rubick.yaml` file will be placed in the `~/.rubick` hidden directory:

    bash init.sh
    
### Configuring Rubick

**Setting Your Provider**

Rubick uses `virtualbox` to be Vagrant provider.
    
**Configuring Shared Folders**

The `folders` property of the `Rubick.yaml` file lists all of the folders you wish to share with your Rubick environment. As files within these folders are changed, they will be kept in sync between your local machine and the Rubick environment. You may configure as many shared folders as necessary:

    folders:
        - map: ~/Code
          to: /home/vagrant/Code
          
To enable `NFS`, just add a simple flag to your synced folder configuration:

    folders:
        - map: ~/Code
          to: /home/vagrant/Code
          type: "nfs"

**Quickstart Your Sites**

To start Rails built-in web sever WEBrick, you may use the `bin/rails server -b 0.0.0.0` command or alias `rs`. Once you have started the Rails built-in web server, you can access the site via your web browser:

    http://localhost:3000

To start Hanami built-in web sever WEBrick, you may use the `bundle exec hanami server --host=0.0.0.0` command or alias `hs`. Once you have started the Hanami built-in web server, you can access the site via your web browser:

    http://localhost:2300

**Configuring Nginx Sites**

Not familiar with Nginx? No problem. The `sites` property allows you to easily map a "domain" to a folder on your Rubick environment. A sample site configuration is included in the `Rubick.yaml` file. Again, you may add as many sites to your Rubick environment as necessary. Rubick can serve as a convenient, virtualized environment for every Laravel project you are working on:

    sites:
        - map: rubick.app
          to: /home/vagrant/Code/rubick/public
      
If you change the `sites` property after provisioning the Rubick box, you should re-run `vagrant reload --provision` to update the Nginx configuration on the virtual machine.

**The Hosts File**

You must add the "domains" for your Nginx sites to the `hosts` file on your machine. The `hosts` file will redirect requests for your Rubick sites into your Rubick machine. On Mac and Linux, this file is located at `/etc/hosts`. On Windows, it is located at `C:\Windows\System32\drivers\etc\hosts`. The lines you add to this file will look like the following:

    192.168.10.10  rubick.app

Make sure the IP address listed is the one set in your `~/.rubick/Rubick.yaml` file. Once you have added the domain to your `hosts` file, you can access the site via your web browser:

    http://rubick.app

### Launching The Vagrant Box

Once you have edited the `Rubick.yaml` to your liking, run the `vagrant up` command from your Rubick directory. Vagrant will boot the virtual machine and automatically configure your shared folders and Nginx sites.

To destroy the machine, you may use the `vagrant destroy --force` command.

## Daily Usage

### Connecting Via SSH

You can SSH into your virtual machine by issuing the `vagrant ssh` terminal command from your Rubick directory.

But, since you will probably need to SSH into your Rubick machine frequently, consider adding the "alias" described above to your host machine to quickly SSH into the Rubick box.

### Connecting To Databases

A `rubick` database is configured for both MySQL and Postgres out of the box.

To connect to your MySQL or Postgres database from your host machine via Navicat or Sequel Pro, you should connect to `127.0.0.1` and port `33060` (MySQL) or `54320` (Postgres). The username and password for both databases is `rubick / secret`.

> Note: You should only use these non-standard ports when connecting to the databases from 
> your host machine. You will use the default 3306 and 5432 ports in your database configuration 
> file since the application is running within the virtual machine.

### Adding Additional Sites

Once your Rubick environment is provisioned and running, you may want to add additional Nginx sites for your Ruby applications. You can run as many Ruby installations as you wish on a single Rubick environment. To add an additional site, simply add the site to your `~/.rubick/Rubick.yaml` file and then run the `vagrant provision` terminal command from your Rubick directory.

### Ports

By default, the following ports are forwarded to your Rubick environment:

* Rails: 3000 → Forwards To 3000
* Hanami: 2300 → Forwards To 2300
* SSH: 2222 → Forwards To 22
* HTTP: 8000 → Forwards To 80
* HTTPS: 44300 → Forwards To 443
* MySQL: 33060 → Forwards To 3306
* Postgres: 54320 → Forwards To 5432

**Forwarding Additional Ports**

If you wish, you may forward additional ports to the Vagrant box, as well as specify their protocol:

    ports:
        - send: 93000
          to: 9300
        - send: 7777
          to: 777
          protocol: udp
