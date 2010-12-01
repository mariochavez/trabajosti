class JobsController < InheritedResources::Base
  actions :new, :create, :show, :edit, :update

  def edit
    @job = Job.find params[:id]

    if !@job.token.nil?
      if @job.token != params[:token]
        flash[:error] = 'Esta oferta ya fué publicada, para modificarla use el token que se le asignó al publicarla'
        return redirect_to root_path
      end
    end

    edit!
  end

  def update
    
    update! {
      if !@job.token.nil?
        flash[:notice] = 'Su oferta ha sido actualizada'
        return redirect_to root_path
      end
    }
  end

  def publish
    @job = Job.find params[:id]  

#    if !@job.token.nil?
#      flash[:error] = 'Esta oferta ya fué publicada y no es posible publicarla nuevamente'
#      return redirect_to root_path
#    end

    @job.publish!
  end
end
