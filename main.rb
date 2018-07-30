require 'erb'
require 'json'

class CvGenerator

  def initialize(params, template_string)
    @params = params
    @template = ERB.new(template_string)
  end

  def generate_html
    @template.result(binding)
  end

  def generate_pdf
    kit = PDFKit.new(generate_html)
    kit.stylesheets << 'styles.css'
    pdf = kit.to_pdf
    # file = kit.to_file('generated.pdf')
  end
end




params = JSON.load(File.new("data.json"))
template_string = File.read("template.html.erb")
generator = CvGenerator.new(params, template_string)

html = generator.generate_html()
puts html
File.write('generated.html', html)