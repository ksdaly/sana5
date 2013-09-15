class CreateHealthProfile < ActiveRecord::Migration
  def change
    create_table :health_profiles do |t|
      t.integer :user_id
      t.boolean :male, default: false
      t.date :dob, null: false
      t.integer :weight, null: false
      t.integer :height, null: false
      t.integer :systolic_bp, null: false
      t.integer :diastolic_bp, null: false
      t.boolean :antihypertensive_drugs, default: false
      t.boolean :steroid_drugs, default: false
      t.boolean :diabetes, default: false
      t.boolean :parent_with_diabetes, default: false
      t.boolean :sibling_with_diabetes, default: false
      t.boolean :smoker, default: false
      t.boolean :exsmoker, default: false
      t.decimal :cardiovascular_risk, precision: 5, scale: 2
      t.decimal :diabetes_risk, precision: 5, scale: 2

      t.timestamps
    end
  end
end
