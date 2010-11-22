require 'spec_helper'

describe JobsController do

  describe "POST 'publish'" do
    it "should publish the job and generate a token" do
      job = Factory.create :job
      Job.stub(:find).with(job.id) { job }
      
      post :publish, :id => job.id, :job => {}

      assigns(:job).should be(job)
      job.token.should_not == nil
      response.should be_success
    end

    it "should not allow to publish a published job" do
      job = Factory.create :job
      job.publish!
      Job.stub(:find).with(job.id) { job }
      
      post :publish, :id => job.id, :job => {}
      response.should redirect_to(root_url)
      flash[:error].should == 'Esta oferta ya fué publicada y no es posible publicarla nuevamente'
    end
  end

end
