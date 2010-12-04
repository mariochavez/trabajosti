require 'spec_helper'

describe JobsController do

  before(:each) do
      @job = Factory.create :job
      Job.stub(:find).with(@job.id).and_return(@job)
  end

  describe "POST 'publish'" do
    it "debe permitir publicar la oferta si no ha sido publicada" do
      Job.stub!(:save).and_return(true)
      @job.should_receive(:save)
      post :publish, :id => @job.id, :job => {}

      @job.published.should == true
      response.should be_success
    end

    context "cuando la oferta es publicada" do
      it "debe de enviar un email con la informacion de la oferta" do
        Job.stub!(:save).and_return(true)
        JobMailer.stub!(:deliver_confirmation)

        JobMailer.should_receive(:deliver_confirmation).with(@job)
        post :publish, :id => @job.id, :job => {}
      end

      it "debe twittear la oferta" do
        Job.stub!(:save).and_return(true)
        JobMailer.stub!(:deliver_confirmation)
        Twitter.stub!(:update)

        message = "#{@job.company_name} busca #{@job.title} en #{@job.location}; mas info: #{dashboard_url(@job.id)}"
        Twitter.should_receive(:update).with(message)
        post :publish, :id => @job.id, :job => {}
      end
    end

    it "no debe permitir publicar la oferta si ya fue publicada" do
      @job.published = true
      @job.should_not_receive(:save) 

      post :publish, :id => @job.id, :job => {}

    end

    context "cuando la oferta no es publicada" do
      before(:each) do
        @job.published = true
        post :publish, :id => @job.id, :job => {}
      end

      it "debe redireccionar a la pagina principal" do
        response.should redirect_to(root_url)
      end

      it "debe de mostrar mensaje flash[:error]" do
        flash[:error].should == 'Esta oferta ya fué publicada y no es posible publicarla nuevamente'
      end
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
      response.should be_success
    end

    it "should not show without token" do
      get :show, :id => @job.id

      response.should redirect_to(root_url)
      flash[:error].should == 'No es posible previsualizar esta oferta sin el token correcto'
    end
  end

  describe "PUT 'update'" do
    it "no debe permitir actualizar si el token no es el correcto" do
      @job.should_not_receive(:update_attributes)

      put :update, :id => @job.id, :job => {:token => 'token invalido'}
    end

    context "cuando la oferta no es actualizada" do
      before(:each) do
        put :update, :id => @job.id, :job => {:token => 'token invalido'}
      end

      it "debe de mostrar el mensahe de flash[:error]" do
        flash[:error].should == 'No es posible actualizar la oferta sin el token correcto' 
      end

      it "debe redireccionar a la pagina principal" do
        response.should redirect_to(root_path)
      end
    end

    it "debe permitir actualizacion si el token es el correcto" do
      Job.stub!(:update_attributes).and_return(true)
      @job.should_receive(:update_attributes)

      put :update, :id => @job.id, :job => {:token => @job.token}
    end

    context "cuando la oferta es actualizada" do
      before(:each) do
        Job.stub!(:update_attributes).and_return(true)
      end

      it "debe mostrar mensaje de flash[:notice] cuando la oferta esta publicada" do
        @job.published = true
        put :update, :id => @job.id, :job => {:token => @job.token}

        flash[:notice].should == 'Su oferta ha sido actualizada'
      end

      it "debe redireccionar a la pagina principal cuando la oferta esta publicada" do
        @job.published = true
        put :update, :id => @job.id, :job => {:token => @job.token}

        response.should redirect_to(root_path)
      end

      it "no debe mostrar mensaje de flash[:notice] cuando la oferta no esta publicada" do
        @job.published = false
        put :update, :id => @job.id, :job => {:token => @job.token}

        flash[:notice].should == nil
      end

      it "debe redireccionar a preview cuando la oferta no esta publicada" do
        @job.published = false
        put :update, :id => @job.id, :job => {:token => @job.token}

        response.should redirect_to(show_job_path(@job.id, @job.token))
      end
    end
  end
end
