class Job < ActiveRecord::Base
  validates_presence_of :title, :message => 'Por favor indique un título'
  validates_presence_of :location, :message => 'Por favor indique la ubicación'
  validates_presence_of :description, :message => 'Por favor indique una descripción'
  validates_presence_of :contact, :message => 'Por favor indique como recibir contacto por la oferta'
  validates_presence_of :email, :message => 'Por favor indique su dirección de correo electrónico'

  scope :latest, where('token is not null').where('created_at >= ?', Date.today - 30).order('created_at desc')

  scope :limited, limit(20)

  def publish!
    return if self.new_record?
    self.token = ActiveSupport::SecureRandom.base64(32).gsub("/","_").gsub(/=+$/,"")  

    self.save
  end
end
