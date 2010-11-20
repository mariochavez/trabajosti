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
      '#job_title' => job.title,
      '#job_category' => job.category,
      '#job_location' => job.location,
      '#job_description' => job.description,
      '#job_contact' => job.contact,
      '#job_company_name' => job.company_name,
      '#job_url' => job.url,
      '#job_email' => job.email
    )

    click_link_or_button 'Paso 2: ver la oferta'

    should_be_on preview_job
    page.should hace_css 'h1', :text => 'Paso 2: Vista previa de la oderta'
    page.should have_css 'h1', :text => job.title
    page.should have_css 'h2', :text => job.company
    page.should have_css 'h3', :text => job.location

    page.shoud have_css 'input', :text => 'Paso 3: publicar oferta'
  end
end
