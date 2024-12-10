require 'csv'

class ReportMailer < ActionMailer::Base
  default from: 'no-reply@puntospoint.com'

  def daily_report(file_path, recipients, _purchases)
    attachments["daily_report_#{Date.today}.xlsx"] = File.binread(file_path)

    mail(
      to: 'dantealonsoh@gmail.com', # recipients.first,
      cc: recipients.drop(1),
      subject: "Daily Report for #{Date.today}"
    ) do |format|
      format.text { render plain: 'Please find the attached daily report.' }
    end
  end
end
