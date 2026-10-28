require 'selenium-webdriver'
Selenium::WebDriver.logger.level = :warn
require 'json'
require 'fileutils'
options=Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless=new')
options.add_argument('--hide-scrollbars')
options.add_option('goog:loggingPrefs', {browser: 'ALL'})
driver=Selenium::WebDriver.for(:chrome,options:options)
report=[]
begin
[320,390,540,768,1024,1440,1920].each do |width|
 driver.execute_cdp('Emulation.setDeviceMetricsOverride',width:width,height:1000,deviceScaleFactor:1,mobile:false)
 driver.get('http://127.0.0.1:8001')
 driver.execute_async_script('let done=arguments[0];document.fonts.ready.then(()=>Promise.all([...document.images].map(i=>{i.loading="eager";return i.decode().catch(()=>{})}))).then(done)')
 metrics=driver.execute_script(<<~JS)
 return {width:innerWidth,scrollWidth:document.documentElement.scrollWidth,broken:[...document.images].filter(i=>!i.naturalWidth).map(i=>i.src),overflow:[...document.querySelectorAll('h1,h2,h3,p,a.button,button.button')].filter(e=>e.getClientRects().length&&!e.closest('dialog:not([open])')).filter(e=>e.scrollWidth>e.clientWidth+2||e.getBoundingClientRect().right>innerWidth+1||e.getBoundingClientRect().left < -1).map(e=>({text:e.textContent.trim(),width:e.clientWidth,scroll:e.scrollWidth})),contacts:[...document.querySelectorAll('a[href*="wa.me"]')].every(a=>new URL(a.href).pathname==='/556993776427')}
 JS
 if width <= 760
  driver.find_element(css:'.menu-toggle').click
  raise 'Menu did not open' unless driver.find_element(css:'.menu-toggle')['aria-expanded']=='true'
  driver.find_element(css:'nav a[href="#sobre"]').click
  raise 'Menu did not close' unless driver.find_element(css:'.menu-toggle')['aria-expanded']=='false'
 end
 ['reportagem-dialog','premio-dialog','parceria-dialog'].each do |id|
  driver.execute_script("document.querySelector('[data-open=\"#{id}\"]').click()")
  raise 'Dialog did not open' unless driver.execute_script("return document.getElementById('#{id}').open")
  driver.action.send_keys(:escape).perform
  raise 'Dialog did not close' if driver.execute_script("return document.getElementById('#{id}').open")
 end
 driver.execute_script('document.activeElement.blur(); document.body.tabIndex=-1; document.body.focus()')
 driver.execute_script('window.scrollTo({top:0,behavior:"instant"})')
 if [390,1024,1440].include?(width)
  height=driver.execute_script('return document.documentElement.scrollHeight')
  shot=driver.execute_cdp('Page.captureScreenshot',captureBeyondViewport:true,clip:{x:0,y:0,width:width,height:height,scale:1})
  require 'base64'
  File.binwrite("inacio-rocha/qa/desktop-#{width}.png",Base64.decode64(shot['data']))
 end
 metrics['errors']=driver.logs.get(:browser).select{|e|e.level=='SEVERE'}.map(&:message)
 report<<metrics
 puts JSON.generate(metrics)
end
ensure
 driver.quit
 File.write('inacio-rocha/qa/report.json',JSON.pretty_generate(report))
end
abort 'Layout verification failed' if report.any?{|m|m['scrollWidth']>m['width']||m['broken'].any?||m['overflow'].any?||m['errors'].any?||!m['contacts']}
puts 'PASS: responsive layout, images, menu, dialogs and WhatsApp links.'
