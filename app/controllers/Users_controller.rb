class UsersController < ApplicationController
  def index  
    Redis.current.flushall
    # session.destroy
    puts "================== REDIS CLEARED EVERYTHING ====================="
  end
end
