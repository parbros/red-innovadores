# encoding: utf-8

class RedInnovacionMailer < ActionMailer::Base
  default :from => Refinery::Setting.find_or_set("memberships_sender_address", nil)
  
  def confirmation(member)
    @member = member
    mail(:to => "#{member.full_name} <#{member.email}>", :subject => "#{member.full_name} Bienvenido a Red Innovación")
  end
  
  def reset_password(member)
    @member = member
    mail(:to => "#{member.full_name} <#{member.email}>", :subject => "#{member.full_name} Bienvenido a Red Innovación")
  end
  
  def comment_has_respond(comment)
    @comment = comment
    @name = comment.user ? comment.user.full_name : comment.name
    @email = comment.user ? comment.user.email : comment.email
    mail(:to => "#{@name} <#{@email}>", :subject => "#{@email} Tu comentarios ha sido respondido.")
  end
end
