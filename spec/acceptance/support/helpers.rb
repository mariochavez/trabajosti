module HelperMethods
  def should_be_on(path)
    current_path.should == path
  end
  
  def should_not_be_on(path)
    current_path.should != path
  end

  def have_the_following(fields=[])
    fields.each do |field|
     page.should have_css field 
    end
  end

  def fill_the_following(fields={})
    fields.each do |field, value|
      fill_in field,  :with => value
    end
  end

  def should_have_errors(*messages)
    within(:css, "#error_explanation") do
      messages.each { |msg| page.should have_content(msg) }
    end
  end
  alias_method :should_have_error, :should_have_errors
  
end

RSpec.configuration.include HelperMethods, :type => :acceptance
