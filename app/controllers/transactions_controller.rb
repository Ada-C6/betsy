class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @mytransaction = Transaction.new
    @mytransaction.client_name = params[:transaction][:client_name]
    @mytransaction.client_email = params[:transaction][:client_email]
    @mytransaction.client_address = params[:transaction][:client_address]
    @mytransaction.client_cc_num = params[:transaction][:client_cc_num].slice(-4..-1)
    @mytransaction.client_cc_exp = params[:transaction][:client_cc_exp]
    @mytransaction.status = nil
    @mytransaction.total_price = nil
    # @mytransaction.save

  end

  def show
  end

  def show_all
  end

  private
  def user_params
    params.require(:transaction).permit(:client_name, :client_email, :status, :client_address, :client_cc_num, :client_cc_exp)
  end

end
