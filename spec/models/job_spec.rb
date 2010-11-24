require 'spec_helper'

describe Job do

  def self.create_and_publish_40_jobs!
    40.times do
      job = Factory.create :job
      job.publish!
    end
  end

  def self.create_40_jobs!
    40.times do
      job = Factory.create :job
    end
  end

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

  describe "Leer las ultimas 20 ofertas" do
    Job.delete_all
    create_and_publish_40_jobs!

    jobs = Job.latest.limited.all
    jobs.count.should == 20
  end

  describe "Leer el resto de las ofertas" do
    Job.delete_all
    HelperMethods.create_and_publish_40_jobs!

    jobs = Job.latest.all
    jobs.count.should == 40
  end

  describe "No debe leer ofertas si no estan publicadas" do
    Job.delete_all
    create_40_jobs!

    jobs = Job.latest.all
    jobs.count.should == 0
  end
end
