Vagrant Zen Cart development box
=======

We have created a Vagrant box that is provisioned to allow for use as a development platform for Zen Cart.

The base box this is based on  [Ubuntu 14.04 LTS (Trusty Tahr)](https://vagrantcloud.com/ubuntu/trusty64)

We have added

* Apache 2.4.7 with SSL
* mySql 5.5.37
* php 5.5.9
* phpMyAdmin 4.0.10
* git 1.9.1

Full details of other php/apache modules added can be found here.

Basic Installation Instructions
-------

You need to install [Virtualbox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](http://www.vagrantup.com/downloads.html) first.

With those installed we need to do some configuration.

The Zen Cart vagrant box uses private networking to bridge between your host computer and the Vagrant virtual machine.
In order for this to work correctly, you need to add an entry in your hosts file.

<pre><code>172.22.22.22 zen.local</code></pre>

The benefit of this is that you will be able to just use **http://zen.local** as the domain in your browser, without having to worry about adding ports (eg. :8080 :8443) to the URL.

You  will then need to create a directory for your Zen Cart vagrant installation.

Change into this directory and then run the following command.

<pre><code>vagrant box add zencart-v160-dev https://s3.amazonaws.com/zencart-vagrant-boxes/zencart-v160-dev.box</code></pre>

followed by

<pre><code>vagrant init zencart-v160-dev</code></pre>

Before actually starting up the box, you should grab yourself a copy of the Zen Cart Github repository for v1.6.0.

The Zen Cart vagrant box defines a directory called webroot, that it uses to share code between your host machine and the Vagrant VM.
Such that anything in the webroot directory will be served by the **http://zen.local** url.

You can therefore either clone the Zen Cart repository directly as the webroot directory or as a sub directory of webroot.
for example if you cloned the repository to webroot/zencart then it would be accessed as **http://zencart/...**

If you want to clone directly as the webroot directory then you can juts do

<pre><code>git clone https://github.com/zencart/zc-v1-series.git webroot</code></pre>

otherwise you would first have to create the webroot directory then do
<pre><code>git clone https://github.com/zencart/zc-v1-series.git webroot/zencart</code></pre>

With that done, you can now do
<pre><code>vagrant up</code></pre>

Once the box is up and running, as mentioned earlier, it should be accessible in your browser using **http://zen.local** or **https://zen.local**
You also have access to a phpMyAdmin instance at **http://zen.local/phpmyadmin**

There are some preset passwords as well.
phpMyAdmin uses
<pre><code>
user = root<br>
password = zencart
</code></pre>

There is a default database called zencart already setup and this too uses
<pre><code>
user = root<br>
password = zencart
</code></pre>

Developer Notes
-------

To make life a bit easier for developer, we have provided 2 overrides.

The first relates to the installer. In zc_install/extra_configures you can add a php file

<pre><code>
&lt;?php <br>
define('DEVELOPER_MODE', true);
</code></pre>

This will disable admin directory renaming e.g. leaving the admin directory named 'admin' and also setting the initial admin temp password to **developer1** instead of a random string.

You can also add a file to admin/includes/extra_configures

<pre><code>
&lt;?php <br>
define('ADMIN_BLOCK_WARNING_OVERRIDE', true);
</code></pre>

This disables the blocking alert page that requires you to  delete the install directory and rename the admin directory.

Detailed Installation Instructions
--------


### Ubuntu ###

Install Virtualbox
<pre><code>sudo apt-get install virtualbox</code></pre>

Install Vagrant
<pre><code>sudo apt-get install vagrant</code></pre>

Update hosts file
<pre><code>sudo echo "172.22.22.22 zen.local" >> /etc/hosts</code></pre>

Create working directory
<pre><code>
mkdir ~/zen-vagrant<br>
cd ~/zen-vagrant</code></pre>

Download Zen Cart v1.6.0
<pre><code>git clone https://github.com/zencart/zc-v1-series.git webroot</code></pre>

Create and start Vagrant Virtual Machine
<pre><code>
vagrant box add zencart-v160-dev https://s3.amazonaws.com/zencart-vagrant-boxes/zencart-v160-dev.box<br>
vagrant init zencart-v160-dev<br>
vagrant up</code></pre>

### Windows ###
@todo
### Mac ###
@todo

**Please feel free to clone this repository and contribute to this documentation**
