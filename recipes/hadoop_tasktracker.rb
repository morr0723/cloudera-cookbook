#
# Cookbook Name:: cloudera
# Recipe:: hadoop_tasktracker
#
# Author:: Cliff Erson (<cerson@me.com>)
# Copyright 2012, Riot Games
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "cloudera"

package "hadoop-#{node[:hadoop][:version]}-tasktracker"

# Create some data dirs. We might not need this
directory "/var/lib/hadoop/tmpdir" do
  mode 0755
  owner "hdfs"
  group "hdfs"
  action :create
  recursive true
end

template "/etc/init.d/hadoop-0.20-tasktracker" do
  mode 0755
  owner "root"
  group "root"
  variables(
    :java_home => node[:java][:java_home]
  )
end

service "hadoop-#{node[:hadoop][:version]}-datanode" do
  action [ :start, :enable ]
end
