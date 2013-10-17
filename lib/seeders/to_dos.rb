module Seeders
  module ToDos

    class << self

      def seed
        seed_plan("Diabetes plan")
        seed_plan("Heart plan")
      end

      def seed_plan(plan_name)
        list = pick_todos(plan_name)
        list.each do |attributes|
          plan_id = pick_plan(plan_name)
          to_do = ToDo.where("title = ? AND health_plan_id = ?", attributes[:title], plan_id ).first
          if to_do.nil?
            to_do = ToDo.new
            to_do.title = attributes[:title]
            to_do.description = attributes[:description]
            to_do.health_plan_id = plan_id
          else
            to_do.update_attributes(attributes)
          end
          to_do.save!
        end
      end

      def pick_todos(plan_name)
        if plan_name == "Diabetes plan"
          diabetes_to_dos
        elsif plan_name == "Heart plan"
          heart_to_dos
        end
      end

      def pick_plan(plan_name)
        HealthPlan.where(title: plan_name).first.id
      end

      def diabetes_to_dos
        [
          {
            title: "Add protein to your breakfast.",
            description: "If you normally eat cereal, yogurt, or that’s fine. Add 10 grams or so of protein. One easy way is to boil a carton of eggs on Sunday and have two egg whites every morning. You’ll add less than 40 calories to your breakfast, pick up 12 grams of protein, and reduce your level of hunger at lunch.",
            group: "nutrition",
            subgroup: "challenging"
          },
          {
            title: "Get up and walk around every hour.",
            description: "Sitting for extended periods is hazardousto your health. Plus it makes you feel sluggish and inactive. At least once an hour get up and move around. Walk while you talk on the phone. Manage by walking around. Your heart will thank you, and so will your attitude.",
            group: "activity",
            subgroup: "moderate"
          },
          {
            title: "Drink a glass of water 15 minutes before every meal.",
            description: "We all need to drink more water. That’s a given. Plus, when you drink a bottle of water before you eat you’ll already feel a little more full and you won’t be as tempted to eat past the point of hunger. And you’ll create a handy reason to need to take more frequent walks… if only to the restroom.",
            group: "nutrition",
            subgroup: "challenging"
          },
          {
            title: "Stretch throughout the day.",
            description: "It’s impossible to feel good about yourself when you feel achy and sore. The only way to relieve muscle stiffness is to stretch. While the drawings are cheesy, here are some simple stretches you can do at your desk. The key is to stretch before you start to feel stiff. Once you establish the habit, proactively stretching will become automatic.",
            group: "activity",
            subgroup: "easy"
          },
          {
            title: "Make 'lunch' active.",
            description: "You ate at your desk and you’re definitely not full, so now make your lunch break productive. Go for a walk. Do some push-ups or sit-ups. It doesn’t matter what you do as long as you do something. You’ll burn a few calories, burn off some stress, and feel better when you get back in the work saddle. Just as importantly you’ll start to make fitness a part of your daily lifestyle without having to add to your already busy schedule.",
            group: "activity",
            subgroup: "easy"
          },
          {
            title: "Eat a meal replacement bar for an afternoon snack.",
            description: "Sure, many protein bars taste like sawdust. But most are also nutritious, low in calories, and make it easy to stave off the mid-afternoon hunger pangs you’ll inevitably feel after having eaten a light lunch. Don’t get too hung up on nutritional values; just pick a bar that includes 10 or 15 grams of protein and you’ll be fine. Eating a mid-afternoon meal replacement bar doesn’t just bridge the lunch and dinner gap, it’s an easy way to get in the habit of eating smaller meals more frequently.",
            group: "nutrition",
            subgroup: "easy"
          },
          {
            title: "Do something physically challenging once a week.",
            description: "Pick something challenging. Hike to the top of a mountain. Ride your bike to the next town and back. You'll soon start to remember how much you're capable of... and you'll want to do more. Just make sure you pick a goal, not a yardstick. Don’t decide to walk five miles on a treadmill; that’s a yardstick goal. Walk five miles to a certain location instead. Don’t ride 20 miles on a spinner; ride your bicycle to a friend’s house and back. Make the activity accomplishment-based. Accomplishments are fun.",
            group: "activity",
            subgroup: "challenging"
          },
          {
            title: "Meditate for 10 minutes.",
            description: "Meditate for 10 minutes.",
            group: "wellness",
            subgroup: "male"
          },
          {
            title: "Practice yoga for 15 minutes.",
            description: "Meditate for 10 minutes.",
            group: "wellness",
            subgroup: "female"
          }
        ]
      end

      def heart_to_dos
        [
          {
            title: "Add protein to your breakfast.",
            description: "If you normally eat cereal, yogurt, or that’s fine. Add 10 grams or so of protein. One easy way is to boil a carton of eggs on Sunday and have two egg whites every morning. You’ll add less than 40 calories to your breakfast, pick up 12 grams of protein, and reduce your level of hunger at lunch.",
            group: "nutrition",
            subgroup: "challenging"
          },
          {
            title: "Get up and walk around every hour.",
            description: "Sitting for extended periods is hazardousto your health. Plus it makes you feel sluggish and inactive. At least once an hour get up and move around. Walk while you talk on the phone. Manage by walking around. Your heart will thank you, and so will your attitude.",
            group: "activity",
            subgroup: "moderate"
          },
          {
            title: "Drink a glass of water 15 minutes before every meal.",
            description: "We all need to drink more water. That’s a given. Plus, when you drink a bottle of water before you eat you’ll already feel a little more full and you won’t be as tempted to eat past the point of hunger. And you’ll create a handy reason to need to take more frequent walks… if only to the restroom.",
            group: "nutrition",
            subgroup: "challenging"
          },
          {
            title: "Stretch throughout the day.",
            description: "It’s impossible to feel good about yourself when you feel achy and sore. The only way to relieve muscle stiffness is to stretch. While the drawings are cheesy, here are some simple stretches you can do at your desk. The key is to stretch before you start to feel stiff. Once you establish the habit, proactively stretching will become automatic.",
            group: "activity",
            subgroup: "easy"
          },
          {
            title: "Make 'lunch' active.",
            description: "You ate at your desk and you’re definitely not full, so now make your lunch break productive. Go for a walk. Do some push-ups or sit-ups. It doesn’t matter what you do as long as you do something. You’ll burn a few calories, burn off some stress, and feel better when you get back in the work saddle. Just as importantly you’ll start to make fitness a part of your daily lifestyle without having to add to your already busy schedule.",
            group: "activity",
            subgroup: "easy"
          },
          {
            title: "Eat a meal replacement bar for an afternoon snack.",
            description: "Sure, many protein bars taste like sawdust. But most are also nutritious, low in calories, and make it easy to stave off the mid-afternoon hunger pangs you’ll inevitably feel after having eaten a light lunch. Don’t get too hung up on nutritional values; just pick a bar that includes 10 or 15 grams of protein and you’ll be fine. Eating a mid-afternoon meal replacement bar doesn’t just bridge the lunch and dinner gap, it’s an easy way to get in the habit of eating smaller meals more frequently.",
            group: "nutrition",
            subgroup: "easy"
          },
          {
            title: "Do something physically challenging once a week.",
            description: "Pick something challenging. Hike to the top of a mountain. Ride your bike to the next town and back. You'll soon start to remember how much you're capable of... and you'll want to do more. Just make sure you pick a goal, not a yardstick. Don’t decide to walk five miles on a treadmill; that’s a yardstick goal. Walk five miles to a certain location instead. Don’t ride 20 miles on a spinner; ride your bicycle to a friend’s house and back. Make the activity accomplishment-based. Accomplishments are fun.",
            group: "activity",
            subgroup: "challenging"
          },
          {
            title: "Meditate for 10 minutes.",
            description: "Meditate for 10 minutes.",
            group: "wellness",
            subgroup: "male"
          },
          {
            title: "Practice yoga for 15 minutes.",
            description: "Meditate for 10 minutes.",
            group: "wellness",
            subgroup: "female"
          }
        ]
      end

    end
  end
end
