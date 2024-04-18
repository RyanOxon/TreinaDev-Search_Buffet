class BuffetsController < ApplicationController
  def new
    @buffet = Buffet.new
  end
end