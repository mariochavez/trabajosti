require 'spec_helper'

describe Job do
  it { should validate_presence_of :title, :message => 'Por favor indique un título' }
  it { should validate_presence_of :location, :message => 'Por favor indique la ubicación' }
  it { should validate_presence_of :description, :message => 'Por favor indique una descripción' }
  it { should validate_presence_of :contact, :message => 'Por favor indique como recibir contacto por la oferta' }
  it { should validate_presence_of :email, :message => 'Por favor indique su dirección de correo electrónico' }
end
