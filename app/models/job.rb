class Job < ActiveRecord::Base
  validates_presence_of :title, :message => 'Por favor indique un título'
  validates_presence_of :location, :message => 'Por favor indique la ubicación'
  validates_presence_of :description, :message => 'Por favor indique una descripción'
  validates_presence_of :contact, :message => 'Por favor indique como recibir contacto por la oferta'
  validates_presence_of :email, :message => 'Por favor indique su dirección de correo electrónico'
end
