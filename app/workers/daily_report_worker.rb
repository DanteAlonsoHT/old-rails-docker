require 'rubyXL'

class DailyReportWorker
  include Sidekiq::Worker

  def perform
    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]
    worksheet.sheet_name = 'Daily Report'

    worksheet.add_cell(0, 0, 'Product Name')
    worksheet.add_cell(0, 1, 'Total Purchases')
    worksheet.add_cell(0, 2, 'Total Revenue')

    start_time = Time.now.beginning_of_day - 1.day
    end_time = Time.now.beginning_of_day

    purchases = Purchase.joins(:product)
                        .where('purchased_at BETWEEN ? AND ?', start_time, end_time)
                        .group('products.name')
                        .select(
                          'products.name AS product_name,
                          COUNT(purchases.id) AS total_purchases,
                          COALESCE(SUM(purchases.price_at_sale), 0) AS total_revenue'
                        )

    purchases.each_with_index do |purchase, index|
      worksheet.add_cell(index + 1, 0, purchase.product_name)
      worksheet.add_cell(index + 1, 1, purchase.total_purchases.to_i)
      worksheet.add_cell(index + 1, 2, purchase.total_revenue.to_f)
    end

    file_path = Rails.root.join('tmp', "daily_report_#{Date.today}.xlsx")
    workbook.write(file_path)

    send_email_with_report(file_path, purchases)
  end

  private

  def send_email_with_report(file_path, purchases)
    admins = Administrator.pluck(:email)
    ReportMailer.daily_report(file_path, admins, purchases).deliver
  end
end
