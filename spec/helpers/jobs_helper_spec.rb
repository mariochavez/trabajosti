require 'spec_helper'

describe JobsHelper do
  describe "Calcula fecha de expiradion" do
    it "debe calcular fecha de expiracion a 30 dias" do
      job = Factory.create :job
      helper.get_expiration_date(job).should == (job.created_at + (3600 * 24 * 30)).to_s(:simple)
    end
  end

  describe "Opciones de categorias" do
    it "debe regresar un hash con las opciones de categorias" do
      options = {'Programación' => 1, 'Diseño web' => 2, 'Ejecutivo/negocios' => 3, 'Soporte técnico' => 4}
      helper.categories.should == options
    end

    it "debe regresar el nombre de la categoria a partir de un id" do
      helper.category_name(1).should == 'Programación'
    end
  end
end
