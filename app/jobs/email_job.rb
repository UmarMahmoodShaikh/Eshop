class EmailJob < ApplicationJob
  queue_as :default

  def perform(num)
    if num == 1
      puts "-------------------------------------------METHOD FOUND FOR LOGIN-------------------------------------------"
      EmailMailer.login_mail.deliver_now
      return
    elsif num == 4
      puts "-------------------------------------------METHOD FOUND FOR SHOPPER NEW ORDER-------------------------------------------"
      EmailMailer.order_mail.deliver_now
      return 
    elsif num == 5
      puts "-------------------------------------------METHOD FOUND FOR STATUS CHANGE OF AN ORDER-------------------------------------------"
      EmailMailer.order_status_mail.deliver_now
      return 
    end
  end
 end