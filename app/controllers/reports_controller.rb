# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  # GET /reports or /reports.json
  def index
    @reports = Report.all.order(:id).page(params[:page])
  end

  def show
    @comments = @report.comments
  end

  def new
    @report = Report.new
  end

  def edit
    if @report.user == current_user
      render :edit
    else
      render file: Rails.public_path.join('404.html'), status: :not_found
    end
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to report_url(@report),
                  notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params) && @report.user == current_user
      redirect_to report_url(@report),
                  notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @report.user == current_user
      @report.destroy
      redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
    else
      render file: Rails.public_path.join('422.html'), status: :unprocessable_entity
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end
end
