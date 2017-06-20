module LoanHelper
  def no_relation(from_id, to_id, amount)
    loan = Loan.find_by(from_id: from_id, to_id: to_id)
    if loan.present?
      loan.update(amount: loan.amount + amount.to_i)
    elsif
      loan = Loan.find_by(to_id: from_id, from_id: to_id)
      if loan.present?
        new_amount = loan.amount - amount.to_i
        if new_amount < 0
          loan.update(amount: -new_amount, from_id: loan.to_id, to_id: loan.from_id)
        else
          loan.update(amount: new_amount)
        end
      end
    end
    check_loan(loan) if loan.present?
    loan.nil?
  end

  def check_loan(loan)
    loan.destroy if loan.amount.equal?(0)
  end
end
