class JobsController < InheritedResources::Base
  actions :index, :new, :create, :show, :edit, :update

  def index
    redirect_to root_url  
  end

  def create
    create! do |success, failure|
      success.html { redirect_to show_job_path @job.id, @job.token }
    end
  end

  def show
    find_job!

    token = params[:token]

    if !valid_token? token
      flash[:error] = 'No es posible previsualizar esta oferta sin el token correcto'
      return redirect_to root_path
    end

    show!
  end

  def edit
    find_job!

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
    find_job!

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
    find_job! 

    if @job.published
      flash[:error] = 'Esta oferta ya fué publicada y no es posible publicarla nuevamente'
      return redirect_to root_path
    end

    JobMailer.published(@job).deliver
    
    twitter_message = "#{@job.company_name} busca #{@job.title} en #{@job.location}; mas info: #{dashboard_url(@job.id)}"
    Twitter.update twitter_message

    @job.publish!
  end

  private
  def valid_token? token
    return true if @job.token == token
    false
  end

  def find_job!
    @job = nil

    if Job.exists?(params[:id])
      @job = Job.find(params[:id]) 
    else
      flash[:error] = 'Oferta no encontrada.'
      return redirect_to root_path
    end
  end
end
