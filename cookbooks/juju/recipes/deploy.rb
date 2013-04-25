rightscale_marker :begin

node[:juju][:charms].split(',').each do |charm|
  bash "install-#{charm}" do
    code <<-EOF
      juju deploy #{charm}
    EOF
  end
end

rightscale_marker :end
