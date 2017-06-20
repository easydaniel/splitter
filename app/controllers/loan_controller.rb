class LoanController < ApplicationController
  def index
    @loans = Loan.all
  end

  def new
    @loan = Loan.new
  end

  def create
    @loan = Loan.create(loan_params) if no_relation(loan_params[:from_id],
                                                    loan_params[:to_id],
                                                    loan_params[:amount])
    redirect_to root_path
  end

  private

  def loan_params
    params.require(:loan).permit(:from_id, :to_id, :amount)
  end

end
