class GroupsController < ApplicationController
  # before_action :set_group, only: %i[show edit update destroy]
  before_action :set_group, only: %i[show]
  before_action :require_user

  def index
    @groups = current_user.groups.asc unless current_user.groups.size.zero?
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      flash[:success] = "#{@group.name} Group was created successfully"
      redirect_to groups_path
    else
      flash[:error] = @group.errors.full_messages
      render :new
    end
  end

  def show
    if current_user.groups.include? @group
      @expenses = nil
      @expenses = @group.expenses if @group.expenses.exists?
    else
      flash[:danger] = 'You are not allowed to view other users groups'
      redirect_to groups_path
    end
  end

  # def edit; end

  # def update
  #   if @group.update(group_params)
  #     flash[:success] = 'Group name was successfully updated'
  #     redirect_to group_path(@group)
  #   else
  #     flash.now[:danger] = 'Group was not updated'
  #     render 'edit'
  #   end
  # end

  private

  def set_group
    @group = Group.find(params[:id])
  end

    def group_params
      params.require(:group).permit(:name)
    end

  end
