#
# Cookbook Name:: mass-backup
# Provider:: db_backup
#

# Support whyrun
def whyrun_supported?
	true
end

action :create do
	description = "define #{new_resource.name} databases to be backed up for the user #{new_resource.name}"
	converge_by(description) do
		dir = "/home/#{new_resource.name}/backup"

		if new_resource.group == nil
			group = new_resource.name
		else
			group = new_resource.group
		end

		directory "#{dir}" do
			owner new_resource.name
			group group
			mode 0755
			action :create
		end

		directory "#{dir}/db-dump" do
			owner new_resource.name
			group group
			mode 0755
			action :create
		end

		template "#{dir}/#{new_resource.name}_dump.conf" do
			source "db_backup.conf.erb"
			cookbook "mass-backup"
			variables(
				:name => new_resource.name,
				:databases => new_resource.databases
			)
			owner new_resource.name
			group group 
			mode 0644
		end
	end
end


