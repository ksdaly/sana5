module Seeders
  module HealthPlans

    class << self

      def seed
        health_plans.each do |attributes|
          health_plan = HealthPlan.where(title: attributes[:title]).first
          if health_plan.nil?
            health_plan = HealthPlan.new
            health_plan.title = attributes[:title]
            health_plan.description = attributes[:description]
            health_plan.plan_length_days = attributes[:plan_length_days]
          else
            health_plan.update_attributes(attributes)
          end
          health_plan.save
        end
      end

      def health_plans
        [
          {
            title: "Diabetes plan",
            description: "Join our 16-week program and learn to change the factors that put you at risk for diabetes.",
            plan_length_days: 21
          },
          {
            title: "Heart plan",
            description: "Join our 16-week program and learn to change the factors that put you at risk for cardiovascular diseases.",
            plan_length_days: 21
          }
        ]
      end

    end
  end
end
