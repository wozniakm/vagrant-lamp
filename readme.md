## Getting started 

1. Download and install newest VirtualBox and Vagrant 
2. Clone this repository 
3. Clone your project's repository into htdocs directory
4. Run in console "vagrant up"

## Stack

* Ubuntu Xenial 16.04
* Apache 2.4
* PHP 7.0
* MySQL 5.7
* Redis 3.0

There are pre installed phpMyAdmin and phpRedisAdmin.

## Networking

Machine will work under private network with address 192.168.3.3. You should change that if this address is already taken in your network.

## Ports

* localhost:80 points to /htdocs
* localhost:81 points to phpMyAdmin (root/root)
* localhost:82 points to phpRedisAdmin 
* localhost:2222 for ssh (ubuntu/ubuntu)

## Compability

Tested on Windows 10 with Virtualbox 5.1.18 and Vagrant 1.9.3.



