require_relative '../pages/BasePages'
require_relative '../pages/elements/EML'
require 'fileutils'


def base_page
  @base_page ||= BasePages.new(@driver)
end

Given('Abrir la app de MercadoLibre') do
  wait = Selenium::WebDriver::Wait.new(timeout: 15)
  wait.until { @driver.find_element(*EML.buscador).displayed? }
  puts 'La app se abrió correctamente'
end

Then('Buscar en la barra de busqueda playstation') do
  begin
    @driver.find_element(*EML.buscador).click
    sleep 2
    @driver.find_element(*EML.buscador_input).send_keys('playstation 5')
    @driver.press_keycode(66)
    puts 'Búsqueda de PlayStation 5 realizada'
  rescue => e
    puts "Error al realizar la búsqueda: #{e.message}"
  end
end

Then('Filtrar producto por condicion nuevo') do
  begin
    sleep 2
    @driver.find_element(*EML.btn_filtro).click
    sleep 2
    base_page.frameScroll_down(30)
    sleep 2
    @driver.find_element(*EML.opt_nuevo).click
    sleep 2
    puts "Filtro aplicado: Condición 'Nuevo'"
  rescue => e
    puts "Error al aplicar el filtro por condición: #{e.message}"
  end
end

Then('Filtrar producto por localizacion CDMX') do
  begin
    @driver.find_element(*EML.opt_precio).click
    sleep 2
    @driver.find_element(*EML.opt_CDMX).click
    sleep 2
    puts "Filtro aplicado: Localización 'CDMX'"
  rescue => e
    puts "Error al aplicar el filtro por localización: #{e.message}"
  end
end

Then('Filtrar producto por menor precio') do
  begin
    @driver.find_element(*EML.opt_MenorPrecio).click
    sleep 2
    @driver.find_element(*EML.btn_VerResultados).click
    sleep 2
    puts "Filtro aplicado: Ordenar por 'Menor precio'"
  rescue => e
    puts "Error al aplicar el filtro por menor precio: #{e.message}"
  end
end

Then('Obtener los nombres y precios de los cinco primeros productos') do
  base_page.obtener_nombres_y_precios
end
