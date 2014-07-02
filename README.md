mass-backup Cookbook
====================
mass-backup cookbook is the extension over Tartarus and covers the installation of scheduled database (PostgreSQL currently) and filesystem backups.


Requirements
------------

#### packages
see metadata.rb

Attributes
----------

#### mass-backup::default

Tartarus configuration is required in order to successfully run the recipe.

https://github.com/ffuenf/chef-tartarus

Usage
-----
#### mass-backup::default
Just include `mass-backup` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mass-backup]"
  ]
}
```

It installs required bash scripts that are responsible for the backup:
- DB backup script - goes through users in the /home, and searches for "backup" directory where <name>_dump.conf files are executed in order to back up PostgreSQL. The configuration can be created with dedicated resource "mass_backup_db_backup"
  - log file is written to /var/log/backup-db.log
- Filesystem backup script - goes through defined tartarus backup configurations
  - log file is written to /var/log/backup-fs.log

Resource
-----

#### mass_backup_db_backup

Example resource usage:

```ruby
mass_backup_db_backup "myuser" do
  group "mygroup"
  databases(
    "mydb" => {
      "vacuum" => "true"
    }
  )
end
```

Creates backup configuration in /home/myuser/backup/mydb_dump.conf. The resulting dump is taken by FS backup and transfer using Tartarus to the configured location.


Contributing
------------

1. Fork the repository on Github - https://github.com/seges/chef-cookbook-mass-backup
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author:: Ladislav Gazo (<gazo@seges.sk>)
Copyright:: 2014, Seges Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

