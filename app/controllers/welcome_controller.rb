class WelcomeController < ApplicationController
  def index
    flash[:notice] = "欢迎来到Big Show!"
  end
end
