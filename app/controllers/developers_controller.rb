class DevelopersController < ApplicationController
  def index
    @api_key = current_user.api_key
  end

  def create_api_key
    current_user.api_key = SecureRandom.alphanumeric(32)
    if current_user.save
      flash[:notice] = "API key gerada"
    else
      flash[:notice] = "Erro ao gerar API key"
    end
    redirect_to developers_path
  end
end
