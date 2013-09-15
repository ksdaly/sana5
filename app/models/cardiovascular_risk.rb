class CardiovascularRisk

  def initialize(health_profile)
    @health_profile = health_profile
  end

  def total_score
    1 - (@health_profile.male ? 0.88431 : 0.94833) ** exponent
  end

  private

  def age_log
    Math.log(@health_profile.calculated_age)
  end

  def systolic_blood_pressure_log
    Math.log(@health_profile.systolic_bp)
  end

  def bmi_log
    Math.log(@health_profile.calculated_bmi)
  end

  def smoker_score
    @health_profile.smoker ? 1 : 0
  end

  def diabetes_score
    @health_profile.diabetes ? 1 : 0
  end

  def beta_x_age
    age_log * (@health_profile.male ? 3.11296 : 2.72107)
  end

  def beta_x_bp
    case @health_profile.male
    when true
      systolic_blood_pressure_log * (@health_profile.antihypertensive_drugs ? 1.92672 : 1.85508)
    when false
      systolic_blood_pressure_log * (@health_profile.antihypertensive_drugs ? 2.88267 : 2.81291)
    end
  end

  def beta_x_smoker
    smoker_score * (@health_profile.male ? 0.70953 : 0.61868)
  end

  def beta_x_bmi
    bmi_log * (@health_profile.male ? 0.79277 : 0.51125)
  end

  def beta_x_diabetes
    diabetes_score * (@health_profile.male ? 0.5316 : 0.77763)
  end

  def sum_beta_x
    beta_x_age + beta_x_bp + beta_x_smoker + beta_x_bmi + beta_x_diabetes
  end

  def exponent
    Math.exp(sum_beta_x - (@health_profile.male ? 23.9388 : 26.0145))
  end

end
