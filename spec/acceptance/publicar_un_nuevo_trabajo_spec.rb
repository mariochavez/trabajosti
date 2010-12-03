require File.dirname(__FILE__) + '/acceptance_helper'

feature "Publicar Un Nuevo Trabajo", %q{
  Para poder hacer una oferta de trabajo
  Como empresa interesada
  Debo de poder publicar una oferta
} do

  scenario "En la pagina principal al hacer 'clic' en 'Nueva Oferta' se debe de mostrar la forma para la informacion de la oferta" do
    visit homepage
    click_link_or_button 'Nueva oferta'

    should_be_on new_job
    page.should have_css 'h1', :text => 'Paso 1: Crear oferta'

    within :css, 'form' do
      have_the_following(
        '#job_title',
        '#job_category',
        '#job_location',
        '#job_description',
        '#job_contact',
        '#job_company_name',
        '#job_logo',
        '#job_url',
        '#job_email'
      )
    end
  end

  scenario "Al llenar una oferta y tratar de ver el preview sin datos, debe de mostrar los campos que deben ser llenados" do
  
    visit new_job
    click_link_or_button 'Paso 2: ver la oferta'

    should_have_errors(
      'Por favor indique un título',
      'Por favor seleccione una categoría',
      'Por favor indique la ubicación',
      'Por favor indique una descripción',
      'Por favor indique como recibir contacto por la oferta',
      'Por favor indique su dirección de correo electrónico'
    )
  end

  scenario "Al llenar una oferta y tratar de ver el preview, la oferta debera ser mostrada" do

    visit new_job

    job = Factory.build :job

    fill_the_following(
      'job_title' => job.title,
      'job_location' => job.location,
      'job_description' => job.description,
      'job_contact' => job.contact,
      'job_company_name' => job.company_name,
      'job_url' => job.url,
      'job_email' => job.email
    )

    select 'Programación', :from => 'job_category'

    click_link_or_button 'Paso 2: ver la oferta'

    job = Job.last

    page.should have_css 'h1', :text => 'Paso 2: Vista previa de la oferta'
    page.should have_css 'h1', :text => job.title
    page.should have_css 'h3', :text => 'Programación'
    page.should have_css 'h2', :text => job.company_name
    page.should have_css 'span', :text => job.url
    page.should have_css 'h3', :text => job.location
    page.should have_css 'div', :text => job.description
    page.should have_css 'div', :text => job.contact

    page.should have_css 'input[type="submit"]'
    page.should have_css 'a', :text => 'Realizar cambios'
  end

  scenario "Modificar oferta despues de verla en Vista previa" do
    job = create_and_preview_a_job!

    click_link_or_button 'Realizar cambios'

    page.should have_css 'h1', :text => 'Paso 1: Crear oferta'
    within :css, 'form' do
      have_the_following(
        '#job_title',
        '#job_category',
        '#job_location',
        '#job_description',
        '#job_contact',
        '#job_company_name',
        '#job_logo',
        '#job_url',
        '#job_email'
      )
    end
  end

  scenario "Ver la oferta en vista previa, despues de modificarla" do
    job = create_and_edit_a_job!

    click_link_or_button 'Paso 2: ver la oferta'

    should_be_on preview_job(job.id, job.token)
  end

  scenario "Publicar oferta y recibir confirmacion de tiempo y token para edicion" do
    job = create_and_preview_a_job!

    click_link_or_button 'Paso 3: publicar oferta'
    job = Job.find job.id

    page.should have_css('h1', :text => job.title)

    expire_date = job.created_at + (3600 * 24 * 30)
    page.should have_css('h3', :text => 'Expira en 30 días: ' + expire_date.to_s(:simple)) 
    
    page.should have_css('h2', :text => 'Para modificar su oferta, guarde el siguiente vínculo, ya que sin el no le será posible realizar cambios:')
    
    page.should have_css('a', :text => job.token)
    page.should have_css('a', :text => 'Regresar al listado de ofertas')
  end

  scenario "No es posible modificar una oferta ya publicada sin el token" do
    job = publish_a_job
    
    visit edit_job job.id, nil

    page.should have_css('div', :text => 'Esta oferta ya fué publicada, para modificarla use el token que se le asignó al publicarla')
  end

  scenario "No es posible modificar una oferta ya publicada sin el token correcto" do
    job = publish_a_job
    
    visit edit_job job.id, 'token_invalido'

    page.should have_css('div', :text => 'Esta oferta ya fué publicada, para modificarla use el token que se le asignó al publicarla')
  end

  scenario "Modificar oferta publicada con el token correcto" do
    job = publish_a_job
    
    visit edit_job job.id, job.token
    click_link_or_button 'Actualizar oferta'

    page.should have_css('div', :text => 'Su oferta ha sido actualizada')
  end
end
