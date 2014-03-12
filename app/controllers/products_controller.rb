class ProductsController < ApplicationController
  def show
    base_product = "http://ocdn.shazamid.com/orbit/getsmoid/en/US/Play_Web/1/-/US/Web/-/-/50/product/" ;
    response = open( base_product + params[:id]).read
    render json:JSON.parse(response)
  end
end
