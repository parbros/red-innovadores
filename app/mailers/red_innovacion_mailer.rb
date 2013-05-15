# encoding: utf-8

class RedInnovacionMailer < ActionMailer::Base
  default :from => Refinery::Setting.find_or_set("memberships_sender_address", nil)
  
  def confirmation(member)
    @member = member
    mail(:to => "#{member.full_name} <#{member.email}>", :subject => "#{member.full_name} Bienvenido a Red Innovación")
  end
end
