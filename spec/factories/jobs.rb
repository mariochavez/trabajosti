# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :job do |f|
  f.title "Desarrollador Rails"
  f.category 1
  f.location "Tijuana, BC, Mexico"
  f.description "Ingeniero con experiencia en el desarrollo de rails"
  f.contact "Enviar CV a jobs@mail.com"
  f.company_name "Cool Rails"
  f.logo "cool.png"
  f.url "http://www.coolrails.com"
  f.email "jobs@mail.com"
end
