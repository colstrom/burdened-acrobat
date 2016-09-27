require 'aws-sdk'
require 'contracts'

module BurdenedAcrobat
  module Amazon
    module Contracts
      include ::Contracts::Core
      include ::Contracts::Builtin

      LoadBalancerDescription = ::Aws::ElasticLoadBalancing::Types::LoadBalancerDescription
      LoadBalancerDescriptions = Or[SetOf[LoadBalancerDescription], ArrayOf[LoadBalancerDescription]]

      TagDescription = ::Aws::ElasticLoadBalancing::Types::TagDescription
      TagDescriptions = Or[SetOf[TagDescription], ArrayOf[TagDescription]]
    end
  end
end
