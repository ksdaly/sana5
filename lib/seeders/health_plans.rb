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
            description: "Join our 16-week program and learn to change
                          the factors that put you at risk for diabetes.",
          },
          {
            title: "Heart plan",
            description: "Join our 16-week program and learn to change
                          the factors that put you at risk for cardiovascular diseases.",
          },
          {
            title: "Wellness plan",
            description: "In 16 weeks, you’ll be well on your way to a healthier lifestyle.",
          }
        ]
      end

    end
  end
end
