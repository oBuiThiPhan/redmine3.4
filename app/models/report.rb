class Report < ActiveRecord::Base
  REPORT_TYPE = {reportday: 0, reportweek: 1, reportmonth: 2}
  STATUS = {pending: 0, done: 1}

  enum status: STATUS
  enum type_report: REPORT_TYPE

  belongs_to :user

  validates :user, presence: true
  validates :report_date, date: true

  before_create :set_name_report

  scope :report_at, ->(date) do
    time = Time.zone.try{parse(date.to_s) || now}
    where report_date: time.all_day
  end
  scope :with_type, ->(type){where type_report: type}

  private
  def set_name_report
    self.name = "#{user.login}_#{type_report}_#{report_date.to_formatted_s(:number)}"
  end
end
