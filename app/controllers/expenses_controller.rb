class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def new
    @category = Category.find(params[:category_id])
    @expense = flash[:expense] ? Expense.new(flash[:expense]) : Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.author = current_user
    if @expense.save
      flash[:success] = 'Expense Saved Successfully'
      redirect_to category_path(@expense.category_id)
    else
      flash[:error] = @expense.errors.full_messages.join(', ')
      redirect_to new_expense_path(category_id: @expense.category_id), flash: { expense: @expense }
    end
  end

  def edit
    @expense = Expense.find(params[:id])
    @category = @expense.category
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      flash[:success] = 'Expense Updated Successfully'
      redirect_to category_path(@expense.category_id)
    else
      flash[:error] = @expense.errors.full_messages.to_sentence
      redirect_to edit_expense_path(@expense), flash: { expense: @expense }
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.category_id
    begin
      @expense.destroy!
      flash[:success] = 'Expense Deleted Successfully'
    rescue ActiveRecord::RecordNotDestroyed => e
      Rails.logger.error "Failed to destroy expense: #{e.message}"
      flash[:error] = 'Failed to delete expense'
    end
    redirect_to category_path(@expense.category_id)
  end


  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :category_id)
  end
end
