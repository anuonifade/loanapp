class ContributionsController < ApplicationController
  include DashboardsHelper
  before_action :total_contribution, :monthly_contribution, :contribution_duration, :recent_contributions, only: [:index]
  before_action :contribution, only: [:new, :edit, :index, :update]
  before_action :contribution_params, only: [:create, :update]

  def index
  end

  def new
    redirect_to edit_contribution_url(@contribution.id) unless @contribution.nil?
    @new_contribution = Contribution.new
  end

  def create
    @new_contribution = Contribution.new(contribution_params)
    @new_contribution[:profile_id] = @user_profile.id

    if @new_contribution.save
      flash.now[:alert] = "Your contribution has been saved"
      redirect_to contributions_url
    else
      flash.now[:alert] = "Unable to save your contribution. Contact the admin for more details."
    end
  end

  def edit
    redirect_to new_contribution_url(@contribution.id) if @contribution.nil?
  end

  def update
    if @contribution.update(contribution_params)
      @contribution.save
      flash.now[:alert] = "Contribution updated successfully"
      redirect_to contributions_url
    else
      flash.now[:alert] = "Unable to save contribution"
      render :edit
    end
  end

  private

    def total_contribution
      @total_contribution = 0.00
      @total_contribution = MonthlyContribution.where(profile_id: @user_profile.id).all.sum(:amount)
    end

    def monthly_contribution
      @monthly_contribution = 0.00
      @monthly_contribution = Contribution.where(profile_id: @user_profile.id).first[:amount] unless Contribution.where(profile_id: @user_profile.id).first.nil?
    end

    def contribution_duration
      @contribution_duration = 0
      @contribution_duration = MonthlyContribution.where(profile_id: @user_profile.id).count
    end

    def recent_contributions
      @recent_contributions = MonthlyContribution.where(profile_id: @user_profile.id).all.sort_by(&:created_at).reverse
    end

    def contribution
      @contribution = Contribution.where(profile_id: @user_profile.id).first || nil
      @month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    end

    def contribution_params
      params.require(:contribution).permit(Contribution.new.attributes.keys.map(&:to_sym))
    end
end
