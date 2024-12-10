class PurchaseMailer < ActionMailer::Base
  default from: 'no-reply@puntospoint.com'

  def first_purchase_email(product, creator, other_admins)
    @product = product
    @creator = creator

    mail(
      to: 'dantealonsoh@gmail.com', # creator.email,
      cc: other_admins.map(&:email),
      subject: "First purchase of #{product.name}"
    )
  end
end
