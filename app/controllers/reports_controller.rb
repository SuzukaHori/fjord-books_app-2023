# frozen_string_literal: true

class ReportsController < ApplicationController
  include ReportsHelper
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)
    begin
      ActiveRecord::Base.transaction do
        @report.save!
        create_mention(@report)
        redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
      end
    rescue StandardError
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      Mention.where(mentioning_id: @report.id).destroy_all
      create_mention(@report)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def create_mention(report)
    return unless report.content.include?('http://localhost:3000/reports/')

    mentioned_report_ids = create_report_id_array(report.content)
    mentioned_report_ids.each do |mentioned_id|
      mention = report.active_mentions.new(mentioned_id:)
      mention.save!
    end
  end
end
