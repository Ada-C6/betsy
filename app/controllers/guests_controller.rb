class GuestsController < ApplicationController

  before_action :find_guest, only: [:show]
  def index
    @guests = Guest.all
  end

  def show; end

  def new
    @guest = Guest.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_guest
    @guest = Guest.find(params[:id])
  end

end
