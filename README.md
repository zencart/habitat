Vagrant Zen Cart development box
=======

Zen Cart Habitat is a vagrant-managed virtual machine and support files, inspired by [Laravel Homestead](https://github.com/laravel/homestead)

Please see the [instructional site](http://zencart.github.io/habitat) for more details


NOTE:

Also note that the VM box is likely to be updated quite often over the next day or two.

If you're not familiar with vagrant, you can refresh the box with<br>

vagrant destroy<br>
vagrant box remove zencart/habitat<br>
(or vagrant box remove habitat if you had previously installed it as just "habitat")<br>

You can then install the updated box by simply running "vagrant up" (which will automatically download the updated box you "removed" with vagrant box remove)
... or you can manually add the box by hand with:

vagrant box add habitat https://s3.amazonaws.com/zencart-vagrant-boxes/habitat.box


