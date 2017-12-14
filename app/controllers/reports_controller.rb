# Redmine - project management software
# Copyright (C) 2006-2015  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

class ReportsController < ApplicationController
	helper :sort
	include SortHelper
                menu_item :issues, except: %i(index create download)
                before_action :find_project, :authorize, :find_issue_statuses, except: %i(index create download)
                before_action :require_login, only: %i(index create download)


	def index
	sort_init 'id', 'asc'
	sort_update %w(id name report_date status type_report)
	@limit = per_page_option
	scope = Report.all.includes(:user)
	scope = scope.with_type(params[:type_report]) if params[:type_report].present?
	scope = scope.report_at(params[:report_date]) if params[:report_date].present?
	@report_count = scope.count
	@report_pages = Paginator.new @report_count, @limit, params['page']
	@offset ||= @report_pages.offset
	@reports = scope.order(sort_clause).limit(@limit).offset(@offset).to_a
	end


  def download
    report = Report.find_by id: params[:id]

	  Rails.logger.info "--------------------------------------"
	  Rails.logger.info report.link_file
	  Rails.logger.info "--------------------------------------"

   	send_file report.link_file

  end

	def create
		if params[:report_date].present? && params[:type_report].present?
		report = User.current.reports.create report_date: params[:report_date],
		type_report: params[:type_report].to_i
		flash[:notice] = l(:notice_report_successful_create, name: report.name)
		else
		flash[:error] = l(:notice_report_fail_create)
		end
	end
	def current_menu_item
		if [:index].include?(action_name.to_sym)
		:reports
		else
		super
		end
	end
  def issue_report
    @trackers = @project.trackers
    @versions = @project.shared_versions.sort
    @priorities = IssuePriority.all.reverse
    @categories = @project.issue_categories
    @assignees = (Setting.issue_group_assignment? ? @project.principals : @project.users).sort
    @authors = @project.users.sort
    @subprojects = @project.descendants.visible

    @issues_by_tracker = Issue.by_tracker(@project)
    @issues_by_version = Issue.by_version(@project)
    @issues_by_priority = Issue.by_priority(@project)
    @issues_by_category = Issue.by_category(@project)
    @issues_by_assigned_to = Issue.by_assigned_to(@project)
    @issues_by_author = Issue.by_author(@project)
    @issues_by_subproject = Issue.by_subproject(@project) || []

    render :template => "reports/issue_report"
  end

  def issue_report_details
    case params[:detail]
    when "tracker"
      @field = "tracker_id"
      @rows = @project.trackers
      @data = Issue.by_tracker(@project)
      @report_title = l(:field_tracker)
    when "version"
      @field = "fixed_version_id"
      @rows = @project.shared_versions.sort
      @data = Issue.by_version(@project)
      @report_title = l(:field_version)
    when "priority"
      @field = "priority_id"
      @rows = IssuePriority.all.reverse
      @data = Issue.by_priority(@project)
      @report_title = l(:field_priority)
    when "category"
      @field = "category_id"
      @rows = @project.issue_categories
      @data = Issue.by_category(@project)
      @report_title = l(:field_category)
    when "assigned_to"
      @field = "assigned_to_id"
      @rows = (Setting.issue_group_assignment? ? @project.principals : @project.users).sort
      @data = Issue.by_assigned_to(@project)
      @report_title = l(:field_assigned_to)
    when "author"
      @field = "author_id"
      @rows = @project.users.sort
      @data = Issue.by_author(@project)
      @report_title = l(:field_author)
    when "subproject"
      @field = "project_id"
      @rows = @project.descendants.visible
      @data = Issue.by_subproject(@project) || []
      @report_title = l(:field_subproject)
    end

    respond_to do |format|
      if @field
        format.html {}
      else
        format.html { redirect_to :action => 'issue_report', :id => @project }
      end
    end
  end

  private

  def find_issue_statuses
    @statuses = IssueStatus.sorted.to_a
  end
end
