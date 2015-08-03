CHANGELOG
=======

- July 3 2014 - Added initial box
- July 5 2014 - Preparing files for habitat
- July 6 2014 - New box created. Github pages site created
- July 6 2014 - VM box updated. Change Apache user/group and update folder permissions. add composer and some tools
- July 6 2014 - VM box updated. added xdebug
- July 6 2014 - VM Box updated. php.ini changes. Added some tools to shared tools directory
- July 7 2014 - VM Box updated. Updates to helper scripts
- Aug 5 2014  - VM Box updated. Added nginx support
- Aug 13 2014 - VM Box updated. 
	- All habitat core files and scripts updated.
	- Renamed use of habitat.local.yaml to just Habitat.yaml for simplicity.
	- Configured phpMyAdmin to use the habitat/tmp folder for import/export actions.
	- Added ability to specify RSA keys to apply to the VM so that private repositories can be accessed from the VM.
	- Added ability to specify ~/.ssh instead of fully qualified path on most systems.
    - Added ability to add custom mappings to override default synced folder paths. This is mainly to allow specifying a different source dir to be mapped to the default /home/vagrant/web/ used by the default vhost configurations.
- Sept 24 2014 - VM box updated to PHP 5.6
    - Habitat.yaml syntax changed "github:" key to "git_url:" to be more generic
- June 2015 - VM box updated to Ubuntu 14.04.2 LTS, PHP 5.6.10, added doc_root option to yaml syntax
