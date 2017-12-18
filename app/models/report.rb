class Report < ActiveRecord::Base
  REPORT_TYPE = {reportday: 0, reportweek: 1, reportmonth: 2}
  STATUS = {pending: 0, done: 1}

  enum status: STATUS
  enum type_report: REPORT_TYPE

  belongs_to :user
  belongs_to :group

  validates :user, presence: true
  validates :report_date, date: true
  validate :end_date_greater_report_date

  before_create :set_name_report

  scope :report_at, ->(date) do
    time = Time.zone.try{parse(date.to_s) || now}
    where report_date: time.all_day
  end
  scope :with_type, ->(type){where type_report: type}

  scope :search, ->(q) do
    report_date = Time.zone.parse(q[:report_date].to_s)
    end_date = Time.zone.parse(q[:end_date].to_s)
    sql = []
    params = {}
    if report_date.present? && end_date.present?
      sql << "#{table_name}.report_date >= :report_date AND #{table_name}.end_date <= :end_date"
      params[:report_date] = report_date.beginning_of_day
      params[:end_date] = end_date.end_of_day
    elsif report_date.present? || end_date.present?
      column, date = report_date.present? ? ["report_date", report_date] : ["end_date", end_date]
      sql << "#{table_name}.#{column} BETWEEN :start_date AND :end_date"
      params[:start_date] = date.beginning_of_day
      params[:end_date] = date.end_of_day
    end
    if q[:type_report].present?
      sql << " #{table_name}.type_report = :type_report"
      params[:type_report] = q[:type_report]
    end
    if q[:group_id].present?
      sql << " #{table_name}.group_id = :group_id"
      params[:group_id] = q[:group_id]
    end
    if q[:user_id].present?
      sql << " #{table_name}.user_id = :user_id"
      params[:user_id] = q[:user_id]
    end
    joins(:user).where(sql.join(" AND "), params)
  end

  private
  def set_name_report
    self.name = "#{user.login}_#{type_report}_#{report_date.to_formatted_s(:number)}"
  end

  def end_date_greater_report_date
    if end_date && report_date && (end_date < report_date)
      errors.add :end_date, :greater_than_start_date
    end
  end
end
