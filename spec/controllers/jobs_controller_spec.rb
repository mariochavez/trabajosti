require 'spec_helper'

describe JobsController do

  before do
      @job = Factory.create :job
      Job.stub(:find).with(@job.id) { @job }
  end

  describe "POST 'publish'" do
    it "should publish the job and generate a token" do
      post :publish, :id => @job.id, :job => {}

      assigns(:job).should be(@job)
      @job.token.should_not == nil
      response.should be_success
    end

    it "should not allow to publish a published job" do
      @job.publish!
      
      post :publish, :id => @job.id, :job => {}
      response.should redirect_to(root_url)
      flash[:error].should == 'Esta oferta ya fué publicada y no es posible publicarla nuevamente'
    end
  end

  describe "GET 'edit'" do
    it "should allow edit with token" do
      get :edit, :id => @job.id, :token => @job.token

      assigns(:job).should be(@job)
      @job.token.should_not == nil
      response.should be_success
    end

    it "should not allow edit unpublished without token" do
      get :edit, :id => @job.id

      response.should redirect_to(root_url)
      flash[:error].should == 'No es posible modificar esta oferta sin el token correcto'
    end

    it "should not allow edit published without token" do
      @job.publish!
      get :edit, :id => @job.id

      response.should redirect_to(root_url)
      flash[:error].should == 'Esta oferta ya fué publicada, para modificarla use el token que se le asignó al publicarla'
    end
  end

  describe "GET 'show'" do
    it "should allow to show with token" do
      get :show, :id => @job.id, :token => @job.token

      assigns(:job).should be(@job)
      @job.token.should_not == nil
      response.should be_success
    end

    it "should not show without token" do
      get :show, :id => @job.id

      response.should redirect_to(root_url)
      flash[:error].should == 'No es posible previsualizar esta oferta sin el token correcto'
    end
  end
end
