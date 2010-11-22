require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the JobsHelper. For example:
#
# describe JobsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe JobsHelper do
  describe "Calcula fecha de expiradion" do
    it "calcula fecha de expiracion a 30 dias" do
      job = Factory.create :job
      helper.get_expiration_date(job).should == (job.created_at + (3600 * 24 * 30)).to_s(:short)
    end
  end
end
