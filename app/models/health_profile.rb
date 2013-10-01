class HealthProfile < ActiveRecord::Base
  belongs_to :user,
    inverse_of: :health_profiles


  validates_presence_of :dob

  validates_presence_of :weight
  validates_numericality_of :weight
  validates_length_of :weight, in: 2..3

  validates_presence_of :height
  validates_numericality_of :height
  validates_length_of :height, is: 2

  validates_presence_of :systolic_bp
  validates_numericality_of :systolic_bp, greater_than_or_equal_to: 80, less_than_or_equal_to: 180

  validates_presence_of :diastolic_bp
  validates_numericality_of :diastolic_bp, greater_than_or_equal_to: 60, less_than_or_equal_to: 110


  def complete
    if self.valid?
      self.cardiovascular_risk = cardiovascular_risk
      self.diabetes_risk = diabetes_risk
    end
    self.save
  end

  def cardiovascular_risk
    (CardiovascularRisk.new(self).total_score * 100).round(2)
  end

  def diabetes_risk
    (DiabetesRisk.new(self).total_score * 100).round(2)
  end

  def calculated_bmi
    ((weight.to_f/height**2)*703.06957964).round(2)
  end

  def calculated_age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def cardio_risk(date)
    where("date(created_at) = ?",date).cardiovascular_risk || 10
  end

  # def created_date
  #   self.created_at.to_date
  # end

  # def self.cardio_risk_on(user, date)
  #   where(user_id: user.id).where("date(created_at) = ?", date).last.try(:cardiovascular_risk) || 0
  # end

  # def self.diabetes_risk_on(user, date)
  #   where(user_id: user.id).where("date(created_at) = ?", date).last.try(:diabetes_risk) || 0
  # end

  def self.risk_array(user, risk)
    array = []
    self.where(user_id: user.id).each do |health_profile|
      subarray = []
      subarray << health_profile.created_at
      subarray << health_profile.send(risk.to_sym)
      array << subarray
    end
    array
  end


end
