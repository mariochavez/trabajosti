require 'spec_helper'

describe Job do

  it { should validate_presence_of :title, :message => 'Por favor indique un título' }
  it { should validate_presence_of :location, :message => 'Por favor indique la ubicación' }
  it { should validate_presence_of :description, :message => 'Por favor indique una descripción' }
  it { should validate_presence_of :contact, :message => 'Por favor indique como recibir contacto por la oferta' }
  it { should validate_presence_of :email, :message => 'Por favor indique su dirección de correo electrónico' }
  it { should validate_presence_of :company_name, :message => 'Por favor indique el nombre de la compañía' }
  it { should validate_numericality_of :category, :message => 'Por favor seleccione una categoría', :greater_than => 0, :only_integer => true }
  it { should allow_values_for :email, :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, :message => 'Por favor indique una dirección de correo electrónico válida' }

  it { should have_columns :title, :company_name, :url, :location, :description, :contact, :token, :published}

  describe "Acciones y consultas" do

    let(:job) do
      job = Factory.build(:job, :token => nil)
    end

    before(:all) do
      40.times do
        job = Factory.create :job
        job.publish!
      end
  
      40.times do
        job = Factory.create :job
      end
    end

    after(:all) do
      Job.delete_all
    end

    it "Publicar oferta marcandolas como publicadas" do
      job.save
      job.publish!

      job.published.should == true
    end
  
    it "Generar token de edicion para ofertas nuevas" do
      job.save
      job.token.should_not == nil
    end
  
    it "Leer las ultimas 20 ofertas" do
      jobs = Job.latest.limited.all
      jobs.count.should == 20
    end
  
    it "Leer el resto de las ofertas" do
      jobs = Job.latest.all
      jobs.count.should == 40
    end
  
    it "No debe leer ofertas si no estan publicadas" do
      jobs = Job.latest.all
      jobs.count.should == 40
    end
  end
end
