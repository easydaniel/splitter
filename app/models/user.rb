class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def loan(uid)
    inbounds = Loan.where("from_id = ? AND to_id = ?", uid, id).sum(:amount)
    outbounds = Loan.where("from_id = ? AND to_id = ?", id, uid).sum(:amount)
    inbounds - outbounds
  end

  def inbound_ids
    Loan.where("to_id = ?", id).all.pluck(:from_id)
  end

  def outbound_ids
    Loan.where("from_id = ?", id).all.pluck(:to_id)
  end

end
