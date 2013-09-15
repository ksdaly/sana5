class DiabetesRisk

  def initialize(health_profile)
    @health_profile = health_profile
  end

  def total_score
    1 / (1 + exponent)
  end

  private

  def gender_score
    @health_profile.male ? 0 : -0.879
  end

  def ahd_score
    @health_profile.antihypertensive_drugs ? 1.222 : 0
  end

  def steroid_score
    @health_profile.steroid_drugs ? 2.191 : 0
  end

  def age_score
    @health_profile.calculated_age * 0.063
  end

  def bmi_score
    case @health_profile.calculated_bmi
    when 0..25.00 then 0
    when 25.01..27.49 then 0.699
    when 27.50..29.99 then 1.970
    when 30.00..100.00 then 2.518
    end
  end

  def diabetes_history_score
    case
    when @health_profile.parent_with_diabetes && @health_profile.sibling_with_diabetes then 0.753
    when @health_profile.parent_with_diabetes || @health_profile.sibling_with_diabetes then 0.728
    else 0
    end
  end

  def smoking_score
    case
    when @health_profile.smoker then 0.855
    when @health_profile.exsmoker then -0.218
    else 0
    end
  end

  def sum_scores
    gender_score + ahd_score + steroid_score + age_score + bmi_score + diabetes_history_score + smoking_score
  end

  def power
    -(-6.322 + sum_scores)
  end

  def exponent
    Math.exp(power)
  end

end
