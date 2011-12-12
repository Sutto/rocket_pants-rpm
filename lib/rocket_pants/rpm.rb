require "rocket_pants/rpm/version"
require "newrelic_rpm"
require 'new_relic/agent/instrumentation/rails3/action_controller'

module RocketPants
  module RPM
    
    DependencyDetection.defer do
      @name = :rocketpants_controller
      
      depends_on do
        defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i == 3
      end

      depends_on do
        defined?(ActionController) && defined?(ActionController::Base)
      end

      executes do
        NewRelic::Agent.logger.debug 'Installing RocketPants Controller instrumentation'
      end  
      
      executes do
        class RocketPants::Base
          include NewRelic::Agent::Instrumentation::ControllerInstrumentation
          include NewRelic::Agent::Instrumentation::Rails3::ActionController
        end
      end
    end

  end
end
