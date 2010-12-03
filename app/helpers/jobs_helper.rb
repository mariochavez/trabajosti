module JobsHelper
  def get_expiration_date(job)
    expire_date = job.created_at + (3600 * 24 * 30)
    expire_date.to_s(:simple)
  end

  def categories
    @categories ||= {'Programación' => 1, 'Diseño web' => 2, 'Ejecutivo/negocios' => 3, 'Soporte técnico' => 4}
  end

  def category_name id
    @inverted ||= categories.invert
    @inverted[id]
  end
end
