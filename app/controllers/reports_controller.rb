class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  # GET /reports or /reports.json
  def index
    @reports = Report.all
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
      redirect_to report_url(@report)
    end
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to report_url(@report),
                  notice: 'Report was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.user == current_user
      redirect_to report_url(@report),
                  notice: 'Report was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @report.user == current_user
      @report.destroy
      redirect_to reports_url, notice: 'Report was successfully destroyed.'
    else
      redirect_to report_url, notice: "他の人が作成した日報は削除できません"
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params
      .require(:report)
      .permit(:title, :content)
      .merge(user_id: current_user.id)
  end
end
