require "spec_helper"

describe JobMailer do
  describe "published" do
    let(:job) { @job = Factory.create :job }
    let(:mail) { JobMailer.published job }

    it "genera los encabezados" do
      mail.subject.should eq("Empleos TI: #{job.title}")
      mail.to.should eq([job.email])
      mail.from.should eq(["empleosti@decisionesinteligentes.com"])
    end

    it "genera el cuerpo" do
      mail.body.encoded.should =~ /#{job.title}/
    end
  end

end
