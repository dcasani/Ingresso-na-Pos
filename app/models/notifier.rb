class Notifier < ActionMailer::Base
  
  def notification(destination,teacher,student,hashcode)
    recipients destination
    from  "Pós Graduação - IME-USP <ingressonapos@gmail.com>"
    subject "Solicitação de Carta de Recomendação"
    body :teacher => teacher, :student => student, :hashcode => hashcode
    content_type "text/html"
  end

  def notificationenglish(destination,teacher,student,hashcode)
    recipients destination
    from  "Pós Graduação - IME-USP <ingressonapos@gmail.com>"
    subject "Solicitation"
    body :teacher => teacher, :student => student, :hashcode => hashcode
    content_type "text/html"
  end

  #   def newsletter_mail(noticias,user)
  #    recipients user.email
  #    from "Master em Jornalismo <jornalismo@iics.org.br>"
  #    subject "Newsletter - Master em Jornalismo"
  #    body :user => user, :noticias => noticias
  #    content_type "text/html"
  #  end
  #

end
