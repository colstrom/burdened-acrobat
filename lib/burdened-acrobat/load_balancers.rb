require_relative 'amazon/contracts'
require_relative 'amazon/elb'
require_relative 'contracts'

module BurdenedAcrobat
  class LoadBalancers
    include ::Contracts::Core
    include ::Contracts::Builtin
    include Contracts
    include Amazon::Contracts
    include Amazon::Mixins

    Contract KeywordArgs[:service => Optional[Service]] => LoadBalancers
    def initialize(**options)
      @options = options
      refresh!
      self
    end

    Contract None => nil
    def refresh!
      nil.tap do
        all!
        tags!
      end
    end

    def search(&block)
      self.instance_eval(&block)
    end

    Contract None => SetOf[LoadBalancerDescription]
    def all
      @all ||= all!
    end

    Contract None => SetOf[TagDescription]
    def tags
      @tags ||= tags!
    end

    Contract Key => SetOf[TagDescription]
    def tags(key)
      Set.new tags.select { |lb| lb.tags.any? { |tag| tag.key == key.to_s } }
    end

    Contract Key, Value => SetOf[TagDescription]
    def tags(key, value)
      Set.new tags(key).select { |lb| lb.tags.any? { |tag| tag.value == value.to_s } }
    end

    Contract LoadBalancerDescriptions => SetOf[TagDescription]
    def tags(load_balancers)
      Set.new tags.select { |tag| names(load_balancers).include? tag.load_balancer_name }
    end

    Contract None => SetOf[LoadBalancerDescription]
    def tagged
      Set.new all.select { |lb| names(tags).include? lb.load_balancer_name }
    end

    Contract Key => SetOf[LoadBalancerDescription]
    def tagged(key)
      Set.new all.select { |lb| names(tags(key)).include? lb.load_balancer_name }
    end

    Contract Key, Value => SetOf[LoadBalancerDescription]
    def tagged(key, value)
      Set.new all.select { |lb| names(tags(key, value)).include? lb.load_balancer_name }
    end

    Contract TagDescriptions => SetOf[LoadBalancerDescription]
    def tagged(tags)
      Set.new all.select { |lb| names(tags).include? lb.load_balancer_name }
    end

    Contract NamedCollection => SetOf[String]
    def names(load_balancers)
      Set.new load_balancers.map(&:load_balancer_name)
    end

    Contract Names => SetOf[LoadBalancerDescription]
    def named(names)
      Set.new names.map { |name| all.find { |lb| lb.load_balancer_name == name } }
    end

    private

    def service
      @service = @options.fetch(:service) { Amazon::ELB.new }
    end

    def all!
      @all = Set.new service.load_balancers!
    end

    def tags!
      @tags = Set.new service.tags!
    end
  end
end
