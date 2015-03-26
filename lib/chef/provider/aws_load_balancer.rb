require 'chef/provisioning/aws_driver/aws_provider'

class Chef::Provider::AwsInstance < Chef::Provisioning::AWSDriver::AWSProvider
  def destroy_aws_object(load_balancer)
    converge_by "delete load balancer #{new_resource.name} in VPC #{new_resource.vpc} in #{region}" do
      load_balancer.delete
    end
  end
end
