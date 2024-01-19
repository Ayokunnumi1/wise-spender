class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories
    @total_expenses = @categories.sum { |category| category.expenses.sum(:amount) }
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      flash[:success] = 'Category Saved Successfully'
      redirect_to categories_path
    else
      flash[:error] = 'Category Not Saved, try later'
      render :new
    end
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
  @category = Category.find(params[:id])
  if @category.update(category_params)
    redirect_to categories_path, notice: 'Category was successfully updated.'
  else
    render :edit
  end
 end

 def destroy
  @category = Category.find(params[:id])
  @category.destroy
  redirect_to categories_path, notice: 'Category was successfully deleted.'
 end

 def show
  @category = Category.find(params[:id])
  @expenses = @category.expenses
 end
  
end
