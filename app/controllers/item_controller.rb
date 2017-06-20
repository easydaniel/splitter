class ItemController < ApplicationController

  before_action :parse_params

  def new
  end

  def create
    puts params.to_json

  end

  private

  def parse_params
    @total = params[:to_ids].map { |e| e.split(',')[1].to_i }.sum
  end
end
