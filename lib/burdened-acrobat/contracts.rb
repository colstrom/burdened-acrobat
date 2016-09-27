require 'contracts'

module BurdenedAcrobat
  module Contracts
    include ::Contracts::Core
    include ::Contracts::Builtin

    Key = Or[String, Symbol]
    Value = Or[String, Symbol]

    Name = Or[String, Symbol]
    Names = Or[SetOf[Name], ArrayOf[Name]]

    Named = RespondTo[:load_balancer_name]
    NamedCollection = Or[SetOf[Named], ArrayOf[Named]]

    Service = RespondTo[:load_balancers, :load_balancers!, :tags, :tags!]
  end
end
