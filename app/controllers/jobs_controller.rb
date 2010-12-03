class JobsController < InheritedResources::Base
  actions :new, :create, :show, :edit, :update

  def create
    create! do |success, failure|
      success.html { redirect_to show_job_path @job.id, @job.token }
    end
  end

  def show
    @job = Job.find params[:id]
    token = params[:token]

    if !valid_token? token
      flash[:error] = 'No es posible previsualizar esta oferta sin el token correcto'
      return redirect_to root_path
    end

    show!
  end

  def edit
    @job = Job.find params[:id]
    token = params[:token]

    if !valid_token? token
      if @job.published
        flash[:error] = 'Esta oferta ya fué publicada, para modificarla use el token que se le asignó al publicarla'
      else
        flash[:error] = 'No es posible modificar esta oferta sin el token correcto'
      end
      return redirect_to root_path
    end

    edit!
  end

  def update
    @job = Job.find params[:id]
    token = params[:job][:token]

    if !valid_token? token
      flash[:error] = 'No es posible actualizar la oferta sin el token correcto'
      return redirect_to root_path
    end
    
    update! do |success, failure| 
      success.html {
        if @job.published
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

    if @job.published
      flash[:error] = 'Esta oferta ya fué publicada y no es posible publicarla nuevamente'
      return redirect_to root_path
    end

    puts '=============================='
    JobMailer.published(@job).deliver
    @job.publish!
  end

  private
  def valid_token? token
    return true if @job.token == token
    false
  end
end
