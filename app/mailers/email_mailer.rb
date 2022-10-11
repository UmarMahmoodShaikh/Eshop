 class EmailMailer < ApplicationMailer
  default from: 'umar@elgrocer.com'

  def login_mail() #1 FOR LOGIN AN EMAIL WILL BE SENT TO SHOPPER/RETAILER/COMPANY 
   if Redis.current.get("shopper_id") != nil
    # puts"~~~~~~~~~~~~~~~~~~~~~~~~~HELLO SHOPPER~~~~~~~~~~~~~~~~~~~~~~~~~"
    mail(
        to: Redis.current.get("shopper_email") ,
        subject: "E-Shop Login Alert Using: \'#{Redis.current.get("shopper_name")}\' as name", 
        body: "Dear #{Redis.current.get("shopper_name")}, \nThis email is to inform you that you have recently logged into E-Shop \nThank you. \nRegards \nEshop Admin \n\nHappy Shopping"
    )
    return
   elsif Redis.current.get("company_id") != nil
    # puts"~~~~~~~~~~~~~~~~~~~~~~~~~HELLO COMPANY~~~~~~~~~~~~~~~~~~~~~~~~~"
    mail(
        to: Redis.current.get("company_email") ,
        subject: "E-Shop Login Alert Using: \'#{Redis.current.get("company_name")}\' as name", 
        body: "Dear #{Redis.current.get("company_name")}, \nThis email is to inform you that you have recently logged into E-Shop \nThank you. \nRegards \nEshop Admin"
    )
    return 
   elsif Redis.current.get("retailer_id") != nil
    # puts"~~~~~~~~~~~~~~~~~~~~~~~~~HELLO RETAILER~~~~~~~~~~~~~~~~~~~~~~~~~"
    mail(
        to: Redis.current.get("retailer_email") ,
        subject: "E-Shop Login Alert Using: \'#{Redis.current.get("retailer_name")}\' as name", 
        body: "Dear #{Redis.current.get("retailer_name")}, \nThis email is to inform you that you have recently logged into E-Shop \nThank you. \nRegards \nEshop Admin"
    )
    return
   end
  end

  def order_mail() #4 ON EACH ORDER PLACEMENT AN EMAIL WILL BE SENT TO SHOPPER WITH ORDER DETAILS
    @order = Order.where(shopper_id: Redis.current.get("shopper_id"), status: 0)
    # @order = Order.last
    mail(
        to: Redis.current.get("shopper_email"),
        subject: "E-Shop Order Placed", 
        body: "Dear #{Redis.current.get("shopper_name")}, \nThis email is to inform you that you have recently placed and order online at E-Shop
               \nHere is your order summary:
               \nProducts: #{@order[0].products}
               \nAddress: #{@order[0].shopper_address}
               \nTotal: #{@order[0].grand_total}
               \nThank you #{Redis.current.get("shopper_name")}. \nRegards \nEshop Admin \n\nHappy Shopping"
    )
  end


  def order_status_mail() #5 FOR ORDER STATUS CHANGE AN EMAIL WILL BE SENT TO SHOPPER
    Redis.current.set("order_id",9)
    @order = Order.find(Redis.current.get("order_id").to_i)
    @shopper = Shopper.where(id: @order.shopper_id)
    # @order = Order.last
    mail(
        to:  @shopper[0].email,
        subject: "E-Shop Order Status Updated", 
        body: "Dear #{@shopper[0].name}, \nThis email is to inform you that your order status is changed. 
               \nHere is your order summary:
               \nProducts: #{@order.products}
               \nAddress: #{@order.shopper_address}
               \nTotal: #{@order.grand_total}
               \nThank you #{@shopper[0].name}. \nRegards \nEshop Admin \n\nHappy Shopping"
    )
  end
 end