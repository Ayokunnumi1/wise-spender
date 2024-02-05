class IncomesController < ApplicationController
  before_action :authenticate_user!

  def new
    @income = current_user.incomes.build
  end

  def create
    @income = current_user.incomes.build(income_params)
    if @income.save
      flash[:success] = 'Income Added Successfully'
      redirect_to categories_path
    else
      flash[:error] = 'Income Not Saved, try later'
      render :new
    end
  end

  def clear_all
    current_user.incomes.destroy_all
    flash[:success] = 'All incomes cleared successfully.'
    redirect_to categories_path
  end

  private

  def income_params
    params.require(:income).permit(:amount)
  end
end
