#
# Cookbook Name:: juju
# Recipe:: default
#
# Copyright 2013, RightScale Inc
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
rightscale_marker :begin

apt_repository "juju-devel" do
  uri "http://ppa.launchpad.net/juju/devel/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C8068B11"
end

package "juju-core" do
  action :install
end

bash "keygen" do
  code <<-EOF
  ssh-keygen -t rsa -b 2048 -f /root/.ssh/id_rsa -q -N ''
EOF
  not_if "test -e /root/.ssh/id_rsa"
end

directory "/root/.juju" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

require 'md5'
folder_hash=MD5.new.to_s
template "/root/.juju/environments.yaml" do
  source "environments.yaml.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
             :access_key_id => node[:juju][:access_key_id],
             :secret_access_key => node[:juju][:secret_access_key],
             :folder_hash => folder_hash
           )
  action :create
end

rightscale_marker :end