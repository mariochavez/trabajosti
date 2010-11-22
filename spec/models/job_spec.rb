require 'spec_helper'

describe Job do
  it { should validate_presence_of :title, :message => 'Por favor indique un título' }
  it { should validate_presence_of :location, :message => 'Por favor indique la ubicación' }
  it { should validate_presence_of :description, :message => 'Por favor indique una descripción' }
  it { should validate_presence_of :contact, :message => 'Por favor indique como recibir contacto por la oferta' }
  it { should validate_presence_of :email, :message => 'Por favor indique su dirección de correo electrónico' }


  it { should have_columns :title, :company_name, :url, :location, :description, :contact, :logo, :token }


  describe "Generar token para ofertar publicadas" do
    job = Factory.create :job
    job.publish!
    job.token.should_not == nil
  end
end

