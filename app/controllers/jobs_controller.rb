class JobsController < InheritedResources::Base
  actions :new, :create, :show, :edit, :update

  def create
    create! do |success, failure|
      success.html { redirect_to show_job_path @job.id, @job.token }
    end
  end

  def show
    @job = Job.find params[:id]

    if !valid_token?
      flash[:error] = 'No es posible previsualizar esta oferta sin el token correcto'
      return redirect_to root_path
    end

    show!
  end

  def edit
    @job = Job.find params[:id]

    if !valid_token?
      if @job.published?
        flash[:error] = 'Esta oferta ya fué publicada, para modificarla use el token que se le asignó al publicarla'
      else
        flash[:error] = 'No es posible modificar esta oferta sin el token correcto'
      end
      return redirect_to root_path
    end

    edit!
  end

  def update
    
    update! do |success, failure| 
      success.html {
        if @job.published?
          flash[:notice] = 'Su oferta ha sido actualizada'
          return redirect_to root_path
        else
          redirect_to show_job_path @job.id, @job.token
        end
      }
    end
  end

  def publish
    @job = Job.find params[:id]  

    if @job.published?
      flash[:error] = 'Esta oferta ya fué publicada y no es posible publicarla nuevamente'
      return redirect_to root_path
    end

    @job.publish!
  end

  private
  def valid_token?
    return true if @job.token == params[:token]
    false
  end
end
