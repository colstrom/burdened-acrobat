require 'contracts'
require_relative 'contracts'

module BurdenedAcrobat
  module Amazon
    module Mixins
      include ::Contracts::Core
      include ::Contracts::Builtin
      include Contracts

      VPCIdentifier = /vpc-[[:xdigit:]]+/
      SubnetIdentifier = /subnet-[[:xdigit:]]+/
      SecurityGroupIdentifier = /sg-[[:xdigit:]]+/

      Contract VPCIdentifier => SetOf[LoadBalancerDescription]
      def with(vpc)
        Set.new all.select { |lb| lb.vpc_id == vpc }
      end

      Contract SubnetIdentifier => SetOf[LoadBalancerDescription]
      def with(subnet)
        Set.new all.select { |lb| lb.subnets.include? subnet }
      end

      Contract SecurityGroupIdentifier => SetOf[LoadBalancerDescription]
      def with(security_group)
        Set.new all.select { |lb| lb.security_groups.include? security_group }
      end
    end
  end
end
