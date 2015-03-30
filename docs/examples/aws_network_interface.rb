require 'chef/provisioning/aws_driver'
require 'retryable'

with_driver 'aws::us-west-2'

# aws_key_pair 'ref-key-pair-eni'

# aws_dhcp_options 'ref-dhcp-options-eni'

# aws_vpc 'ref-vpc-eni' do
#   cidr_block '10.0.0.0/24'
#   internet_gateway true
#   main_routes '0.0.0.0/0' => :internet_gateway
#   dhcp_options 'ref-dhcp-options-eni'
# end

# aws_security_group 'ref-sg1-eni' do
#   vpc 'ref-vpc-eni'
#   inbound_rules '0.0.0.0/0' => 22
# end

# aws_security_group 'ref-sg2-eni' do
#   vpc 'ref-vpc-eni'
#   inbound_rules 'ref-sg1-eni' => 2224
#   outbound_rules 2224 => 'ref-sg1-eni'
# end

# aws_route_table 'ref-public-eni' do
#   vpc 'ref-vpc-eni'
#   routes '0.0.0.0/0' => :internet_gateway
# end

# aws_subnet 'ref-subnet-eni' do
#   vpc 'ref-vpc-eni'
#   map_public_ip_on_launch true
#   route_table 'ref-public-eni'
# end

# with_machine_options :bootstrap_options => { 
#     :subnet_id => 'ref-subnet-eni',
#     :key_name => 'ref-key-pair-eni',
#     :security_group_ids => ['ref-sg1-eni', 'ref-sg2-eni']
#   }

# machine 'ref-machine-eni-1' do
#   action :allocate
# end

# aws_network_interface 'ref-eni-1' do
#   subnet 'ref-subnet-eni'
#   security_groups ['ref-sg1-eni', 'ref-sg2-eni']
# end

# # raise can not be modifed exception
# # aws_network_interface 'ref-eni-1' do
# #   subnet 'subnet-f0836387'
# # end

# aws_network_interface 'ref-eni-1' do
#   machine 'ref-machine-eni-1'
# end

# aws_network_interface 'ref-eni-1' do
#   machine false
# end

aws_network_interface 'ref-eni-1' do
  action :destroy
end

machine 'ref-machine-eni-1' do
  action :destroy
end

# ruby_block 'wait for instance to terminate' do
#   block do
#     # TODO how do I get the instance here?
#     instance = Chef::Resource::AwsInstance.get_aws_object('ref-machine-eni-1', ?: ?)
#     Retryable.retryable(:tries => 30, :sleep => 2) do
#       raise 'instance never terminated' if instance.status != :terminated
#     end
#   end
# end

aws_subnet 'ref-subnet-eni' do
  action :destroy
end

aws_route_table 'ref-public-eni' do
  action :destroy
end

aws_security_group 'ref-sg2-eni' do
  action :destroy
end

aws_security_group 'ref-sg1-eni' do
  action :destroy
end

aws_vpc 'ref-vpc-eni' do
  action :destroy
end

aws_dhcp_options 'ref-dhcp-options-eni' do
  action :destroy
end
