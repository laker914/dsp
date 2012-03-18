class BillMailer < ActionMailer::Base
  default :from => "laker914@gmail.com"
  
  def send_bill(company , path)
      @company = company
      # attachments["对帐单"] = File.read("#{Rails.root}/public/images/rails.png")
      attachments["对帐单.xls"] = File.read(path)
      mail(:to => "#{company.contact} <#{company.email}>", :subject => "对帐单")
  end
end
