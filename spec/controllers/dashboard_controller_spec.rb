require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    it "should list job offers" do
      jobs = []
      40.times do
        job = Factory.build :job
        jobs << job
      end

      Job.stub_chain(:latest, :limited).and_return(jobs)

      total = jobs.size
      Job.stub_chain(:latest, :count).and_return(total)

      get 'index'
      assigns(:jobs).should == jobs
      assigns(:total).should be(total)
      assigns(:action).should be(nil)
      response.should be_success
    end
  end

  describe "GET 'all'" do
    it "should list all job offers" do
      jobs = []
      40.times do
        job = Factory.build :job
        jobs << job
      end

      Job.stub(:latest).and_return(jobs)

      get 'all'
      assigns(:jobs).should == jobs
      assigns(:action).should == 'all'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should show a job offer" do
      job = Factory.create :job

      Job.stub(:find).with(job.id).and_return(job)

      get 'show', :id => job.id
      assigns(:job).should be(job)
      response.should be_success
    end
  end

end
