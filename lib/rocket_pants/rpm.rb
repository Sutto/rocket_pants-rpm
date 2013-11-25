require "rocket_pants/rpm/version"
require "newrelic_rpm"
require 'new_relic/agent/instrumentation/rails3/action_controller'
require 'new_relic/agent/instrumentation/rails4/action_controller'

module RocketPants
  module RPM

    DependencyDetection.defer do
      @name = :rails3_rocketpants_controller

      depends_on do
        defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i == 3
      end

      depends_on do
        defined?(RocketPants) && defined?(RocketPants::Base)
      end

      executes do
        NewRelic::Agent.logger.debug 'Installing Rails 3 RocketPants Controller instrumentation'
      end

      executes do
        class RocketPants::Base
          include NewRelic::Agent::Instrumentation::ControllerInstrumentation
          include NewRelic::Agent::Instrumentation::Rails3::ActionController
        end
      end
    end

    DependencyDetection.defer do
      @name = :rails4_rocketpants_controller

      depends_on do
        defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i == 4
      end

      depends_on do
        defined?(RocketPants) && defined?(RocketPants::Base)
      end

      executes do
        NewRelic::Agent.logger.debug 'Installing Rails 4 RocketPants Controller instrumentation'
      end

      executes do
        Rails.logger.info "running rpm execute"
        class RocketPants::Base
          include NewRelic::Agent::Instrumentation::ControllerInstrumentation
          include NewRelic::Agent::Instrumentation::Rails4::ActionController
        end

        ActiveSupport::Notifications.subscribe(/^process_action.rocket_pants$/,
          NewRelic::Agent::Instrumentation::ActionControllerSubscriber.new)
      end
    end

  end
end
