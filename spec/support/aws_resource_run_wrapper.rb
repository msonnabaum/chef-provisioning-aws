require 'cheffish/rspec/recipe_run_wrapper'

module AWSSupport
  class AWSResourceRunWrapper < Cheffish::RSpec::RecipeRunWrapper
    def initialize(example, resource_type, name, &properties)
      super(example.chef_config) do
        public_send(resource_type, name, &properties)
      end
      @example = example
      @resource_type = resource_type
      @name = name
      @properties = properties
    end

    attr_reader :example
    attr_reader :resource_type
    attr_reader :name

    def resource
      resources.first
    end

    def to_s
      "#{resource_type}[#{name}]"
    end

    def destroy
      resource_type = self.resource_type
      name = self.name
      example.recipe do
        public_send(resource_type, name) do
          action :destroy
        end
      end.converge
    end

    def aws_object
      resource.aws_object
    end
  end
end
