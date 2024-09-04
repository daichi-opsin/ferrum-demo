class PdfController < ApplicationController
  def index
  end

  def download
    browser = Ferrum::Browser.new(browser_options: { "no-sandbox": nil })
    html = render_to_string "pdf/sample", layout: "pdf"
    browser.go_to("data:text/html;charset=UTF-8,#{ERB::Util.url_encode(html)}")
    b = browser.pdf(
      encoding: :binary,
      format: :A4,
      printBackground: true,
      displayHeaderFooter: true,
      marginTop: 0.5,
      marginBottom: 0.5,
      marginLeft: 0,
      marginRight: 0,
      headerTemplate: render_to_string(partial: "pdf/header"),
      footerTemplate: render_to_string(partial: "pdf/footer"),
    )
    send_data(
      b,
      filename: "sample.pdf",
      type: "application/pdf",
      disposition: "attachment"
    )
    browser.quit
  end
end
