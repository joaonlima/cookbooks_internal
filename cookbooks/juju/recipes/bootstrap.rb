rightscale_marker :begin

bash "juju-bootstrap" do
  code <<-EOF
    juju bootstrap
  EOF
end

rightscale_marker :end
