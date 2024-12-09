class PurchaseMailer < ActionMailer::Base
  default from: 'no-reply@puntospoint.com'

  def first_purchase_email(product, creator, other_admins)
    puts "sending email"
    @product = product
    @creator = creator

    mail(
      to: 'dantealonsoh@gmail.com',
      cc: other_admins.map(&:email),
      subject: "First purchase of #{product.name}"
    )
    puts "finished email"
  end
end
