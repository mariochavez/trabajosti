require 'spec_helper'

describe JobsHelper do
  describe "Calcula fecha de expiradion" do
    it "calcula fecha de expiracion a 30 dias" do
      job = Factory.create :job
      helper.get_expiration_date(job).should == (job.created_at + (3600 * 24 * 30)).to_s(:simple)
    end
  end
end
