require 'aws-sdk'
require_relative 'contracts'

module BurdenedAcrobat
  module Amazon
    class ELB
      include ::Contracts::Core
      include ::Contracts::Builtin
      include Contracts

      Contract Maybe[HashOf[Symbol, Any]] => ELB
      def initialize(**options)
        @options = options
        self
      end

      Contract None => ArrayOf[LoadBalancerDescription]
      def load_balancers
        @load_balancers ||= load_balancers!
      end

      Contract None => ArrayOf[LoadBalancerDescription]
      def load_balancers!
        @load_balancers = provider.describe_load_balancers.load_balancer_descriptions
      end

      Contract None => ArrayOf[String]
      def names
        load_balancers.map(&:load_balancer_name)
      end

      Contract None => ArrayOf[TagDescription]
      def tags
        @tags ||= tags!
      end

      Contract None => ArrayOf[TagDescription]
      def tags!
        @tags = names.each_slice(20).flat_map do |slice|
          provider.describe_tags(load_balancer_names: slice).tag_descriptions
        end
      end

      private

      def provider
        @provider ||= ::Aws::ElasticLoadBalancing::Client.new @options
      end
    end
  end
end
