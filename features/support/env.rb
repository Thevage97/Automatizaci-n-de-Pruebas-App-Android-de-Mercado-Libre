require 'appium_lib'
require 'cucumber'
require 'rspec/expectations'
require 'base64'
require 'fileutils'

require_relative '../pages/elements/EML'

TIMESTAMP        = Time.now.strftime('%Y%m%d_%H%M%S')
RUN_REPORTS_DIR  = File.join('target', "reports_#{TIMESTAMP}")
CUCUMBER_HTML    = 'target/cucumber.html'
CUCUMBER_JSON    = 'target/cucumber.json'
ALLURE_RESULTS   = 'target/allure-reports'

def caps
  {
    caps: {
      platformName:  'Android',
      deviceName:    'cusco',
      appPackage:    'com.mercadolibre',
      appActivity:   '.splash.SplashActivity',
      automationName:'UiAutomator2',
      noReset:       true,
      fullReset:     false,
      autoGrantPermissions: true,
      newCommandTimeout: 300
    },
    appium_lib: {
      server_url: 'http://127.0.0.1:4723'
    }
  }
end

SCREENSHOT_DIR = File.join(Dir.pwd, 'screenshots').freeze
FileUtils.mkdir_p(SCREENSHOT_DIR)

def save_screenshot(driver, prefix, label)
  ts   = Time.now.strftime('%Y%m%d_%H%M%S')
  file = File.join(SCREENSHOT_DIR, "#{prefix}_#{ts}.png")
  File.binwrite(file, Base64.decode64(driver.screenshot_as(:base64)))
  attach(File.open(file), 'image/png', label)
  puts "📸  Screenshot: #{file}"
end

Before do |scenario|
  @driver = Appium::Driver.new(caps, true).start_driver
  Appium.promote_appium_methods self.class
  puts "🚀  Escenario iniciado: #{scenario.name}"
end

AfterStep do |result, test_step|
  next unless result.failed?

  save_screenshot(@driver, "FAIL_#{test_step.text.tr('^A-Za-z0-9_', '_')}", 'Screenshot on failure')
  puts "Falló el paso: #{test_step.text} (#{test_step.location})"
  raise result.exception
end

After do |scenario|
  save_screenshot(@driver, scenario.name.tr('^A-Za-z0-9_', '_'), 'Screenshot on failure') if scenario.failed?
  @driver.quit_driver if @driver
end

at_exit do
  FileUtils.mkdir_p(RUN_REPORTS_DIR)

  { CUCUMBER_HTML => 'cucumber.html',
    CUCUMBER_JSON => 'cucumber.json' }.each do |src, name|
    FileUtils.mv(src, File.join(RUN_REPORTS_DIR, name)) if File.exist?(src)
  end

  if Dir.exist?(ALLURE_RESULTS)
    FileUtils.mv(ALLURE_RESULTS, File.join(RUN_REPORTS_DIR, 'allure-results'))
  end

  puts "Reportes guardados en: #{RUN_REPORTS_DIR}"
end
