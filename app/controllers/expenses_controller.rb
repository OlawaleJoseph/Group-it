class ExpensesController < ApplicationController
  # before_action :set_expense, only: %i[show edit update destroy]
  before_action :require_user

  def index
    @expenses = current_user.expenses.desc.select { |expense| expense.groups.exists? } unless current_user.expenses.size.zero?
  end

  def external
    @expenses = current_user.expenses.desc.reject { |expense| expense.groups.exists? } unless current_user.expenses.size.zero?
  end

  # def show; end

  def new
    @expense = Expense.new
    @groups = current_user.groups
  end

  # def edit; end

  # def create
  #   @expense = current_user.expenses.build(expense_params)
  #   @group = Group.find_by(id: group_params[:group_id])
  #   @expense.groups << @group unless @group.nil?

  #   if @expense.save
  #     flash[:success] = 'Expense created successfully!'
  #     redirect_to expenses_path
  #   else
  #     flash.now[:danger] = 'Expense wasn`t created'
  #     render :new
  #   end
  # end

  # def update
  #   if @expense.update(expense_params)
  #     flash[:success] = 'Expense updated successfully!'
  #     redirect_to expenses_path
  #   else
  #     flash.now[:danger] = 'expense wasn`t updated'
  #     render :edit
  #   end
  # end

  # def destroy
  #   @expense.destroy
  #   redirect_to expenses_path
  # end

  # def set_expense
  #   @expense = Expense.find(params[:id])
  # end

  # def expense_params
  #   params.require(:expense).permit(:name, :amount)
  # end

  # def group_params
  #   params.require(:expense).permit(:group_id)
  # end
end
