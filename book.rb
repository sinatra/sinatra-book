require 'pdfkit'
require 'redcarpet'
require 'fileutils'

module Book
  ASSETS_DIR = File.join(File.dirname(__FILE__), "assets") 
  BOOK_DIR = File.join(File.dirname(__FILE__), "book")
  OUTPUT_DIR = File.join(File.dirname(__FILE__), "output")

  def build(pdf=false)
    check_if_wkhtmltopdf_is_available!

    doc = header
    doc << toc
    doc << content
    if pdf
      kit = PDFKit.new(doc, :page_size=>'Letter')
      kit.stylesheets << "#{ASSETS_DIR}/print.css"
      pdf = kit.to_pdf
      FileUtils.mkdir_p OUTPUT_DIR
      file = kit.to_file("#{OUTPUT_DIR}/sinatra-book.pdf")
    end
    return doc
  end

  private
  def header
    <<-header
      <div id="header">
        <p>
          <img src="#{ASSETS_DIR}/images/book-logo.png" />
        </p>
      </div>
    header
  end

  def toc
    toc_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC)
    <<-toc
      <div id="toc">
        #{toc_renderer.render(complete_markdown)}
      </div>
    toc
  end

  def content
    renderer = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(:with_toc_data => true),
                             :fenced_code_blocks => true)
    <<-content
      <div id="content">
        #{renderer.render(complete_markdown)}
      </div>
    content
  end

  def complete_markdown
    s = []
    File.new("book-order.txt").each_line do |line|
      line.strip!
      next if line =~ /^#/   # Skip comments
      next if line =~ /^$/   # Skip blank lines
      File.open(File.join(BOOK_DIR, line)) do |f|
        s << f.read
      end
    end
    return s.join("\n\n* * *\n\n")
  end

  def check_if_wkhtmltopdf_is_available!
    unless system('which wkhtmltopdf')
      message = <<-EOF


      This command needs the "wkhtmltopdf" binary to be available on the
      system. The installation instructions for various OS platforms are
      available at this link:

      https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF

      Please install that binary first and then run the builder. Aborting now.
      EOF

      puts message
      exit(1)
    end
  end
end
