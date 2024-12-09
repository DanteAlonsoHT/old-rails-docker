class ReportMailer < ActionMailer::Base
  default from: 'no-reply@puntospoint.com'

  def daily_report(file_path, recipients)
    attachments["daily_report_#{Date.today}.xlsx"] = File.read(file_path)
    mail(
      to: recipients,
      subject: "Daily Purchases Report - #{Date.today}"
    )
  end
end
