# Rubick

The official Ruby on Rails and Hanami local development environment.

## Introduction

Rubick is a pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install Ruby, Rails, Hanami, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Rubick runs on any Windows, Mac, or Linux system, and includes the Nginx web server, Ruby 2.2.4, Rails 4.2.5.1, Hanami 0.7.0, MySQL, Postgres, Redis, Memcached, and all of the other goodies you need to develop amazing Ruby applications.

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
* Redis
* Memcached

## Installation & Setup

### First Steps

Before launching your Rubick environment, you must install [VirtualBox 5.x](https://www.virtualbox.org/wiki/Downloads) as well as [Vagrant](https://www.vagrantup.com/downloads.html). All of these software packages provide easy-to-use visual installers for all popular operating systems.

**Installing The Rubick Vagrant Box**

Once VirtualBox and Vagrant have been installed, you should add the ubuntu/trusty64 box to your Vagrant installation using the following command in your terminal. It will take a few minutes to download the box, depending on your Internet connection speed:

    vagrant box add ubuntu/trusty64

If this command fails, make sure your Vagrant installation is up to date.

**Installing Rubick**

You may install Rubick by simply cloning the repository. Consider cloning the repository into a `Rubick` folder within your "home" directory, as the Rubick box will serve as the host to all of your Ruby projects:

    cd ~

    git clone https://github.com/cuonggt/rubick.git Rubick
    
Once you have cloned the Rubick repository, run the `bash init.sh` command from the Rubick directory to create the `Rubick.yaml` configuration file. The `Rubick.yaml` file will be placed in the `~/.rubick` hidden directory:

    bash init.sh
    
### Configuring Rubick

