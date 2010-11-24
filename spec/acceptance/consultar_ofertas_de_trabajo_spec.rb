require File.dirname(__FILE__) + '/acceptance_helper'

feature "Consultar Ofertas De Trabajo", %q{
  Para poder encontrar un nuevo trabajo
  Como usuario que busca ofertas
  Debo de poder consultarlas hasta encontrar una de mi agrado
} do

  background do
    create_and_publish_40_jobs!
    visit homepage
  end

  scenario "Listado de ofertas mas recientes" do
    within :css, 'ul' do
      page.all('li').should have(20).element
    end

    page.should have_css('h1', :text => 'Ofertas recientes')
    page.should have_css('a', :text => 'Ver todas las 40 ofertas')
  end

  scenario "Listado de todas las ofertas disponibles" do
    visit all_job_offers

    within :css, 'ul' do
      page.all('li').should have(40).element
    end

    page.should have_css('h1', :text => 'Todas las ofertas dispoibles')
    page.should have_css('a', :text => 'Regresar a página principal')
  end

  scenario "Estando en la pagina de ofertas recientas, al hacer click en 'Ver todas XX ofertas' debo de ver el resto de las ofertas" do

    click_link_or_button 'Ver todas las 40 ofertas'

    should_be_on all_job_offers
  end

  scenario "En el listado de ofertas al hacer click en una de la ofertas, se debe de mostrar el detalle de la misma" do
    
    offer = ''
    within :css, 'ul' do
      offer = all('a').first[:href]
      find('a').click
    end

    should_be_on offer
  end

  scenario "Al consultar una oferta la informacion detalla debe de ser mostrada" do
    
    job = Factory.create :job
    job.publish!

    visit show_offer(job.id)

    page.should have_css 'h1', :text => job.title
    page.should have_css 'h2', :text => job.company_name
    page.should have_css 'span', :text => job.url
    page.should have_css 'h3', :text => job.location
    page.should have_css 'div', :text => job.description
    page.should have_css 'div', :text => job.contact

    page.should have_css 'a', :text => 'Regresar a ofertas'
    
  end
end
