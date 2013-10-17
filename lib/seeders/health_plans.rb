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
            description: "Your personalized 4-week plan will help you lose weight,
                      change behaviors that place you at risk of developing diabetes,
                      and set you on a path toward a lifetime of healthy living.",
            plan_length_days: 21
          },
          {
            title: "Heart plan",
            description: "Your personalized 4-week plan will help you lose weight,
                      change behaviors that place you at risk of developing cardiovascular disease, and set you on a path toward a lifetime of healthy living.",
            plan_length_days: 21
          }
        ]
      end

    end
  end
end
