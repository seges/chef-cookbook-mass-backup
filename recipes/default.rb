#
# Cookbook Name:: mass-backup
# Recipe:: default
#
# Copyright 2014, Seges
#
# All rights reserved - Do Not Redistribute
#

["backup-db.sh", "backup-fs.sh", "database_dump.sh"].each do |item|
  template "/usr/local/sbin/#{item}" do
    mode 00755
    source "#{item}.erb"
  end
end

cron "backup DB daily" do
  minute "0"
  hour "2"
  command "/usr/local/sbin/backup-db.sh"
end

cron "backup FS incremental workdays" do
  minute "0"
  hour "3"
  # mon-sat
  weekday "1-6"
command "/usr/local/sbin/backup-fs.sh -i"
end

cron "backup FS full sunday" do
  minute "0"
  hour "3"
  # sun
  weekday "0"
  command "/usr/local/sbin/backup-fs.sh"
end

