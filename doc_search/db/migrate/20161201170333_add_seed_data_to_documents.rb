require 'open-uri'
class AddSeedDataToDocuments < ActiveRecord::Migration
    def create(document_params)
      filename = document_params[:pdflink]
      len = filename.length
      if(filename[len-3..len] == "pdf")
        open('Download.pdf', 'wb') do |file|
          file << open(filename).read
        end
        Docsplit.extract_text('Download.pdf', :ocr => false, :output => 'GeneratedText')
        File.delete('Download.pdf')
      elsif(filename[len-3..len] == "png")
        open('Download.png', 'wb') do |file|
          file << open(filename).read
        end
        input_image = 'Download.png'
        `tesseract #{input_image} GeneratedText/Download -l eng`
        File.delete('Download.png')
      end
      @document = Document.new(document_params) 
      @document.save
    end

  def up
    document_params = { title: "Wifi security : wirless network encryption", author: "Gavin Garcia", doctype: "research paper", category:"cyber security", keywords:"wireless network encryption", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EthicalHackingProject.pdf" }
    create(document_params)
    document_params = {title: "Software Crackers", author: "Bryan Degro", doctype: "research paper", category:"cyber security", keywords:"cracker hacker", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Researchpaper.pdf" }        
    create(document_params)
    document_params = {title: "Mobile Malware", author: "Alexander Pons", doctype: "research paper", category:"cyber security", keywords:"malware mobile", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Ethical%20Hacking%20final%20paper%202.0.pdf"}
    create(document_params)
    document_params = {title: "Smart Grid", author: "Oniel Gordon", doctype: "research paper", category:"cyber security", keywords:"smart grid", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Smart%20Grid%20cyber%20physical%20security.pdf" }
    create(document_params)
    document_params = {title: "The Insights into car hacking", author: "Mark Bacchus", doctype: "research paper", category:"cyber security", keywords:"car hacking", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Car%20Hacking%20-%20eel%206931%20final.pdf"}
    create(document_params)
    document_params = {title: "Ethical hacking and counter measures", author: "Pons", doctype: "research paper", category:"cyber security", keywords:"ethical hacking", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EthicalHackingFinalDraft5PageProposal.pdf" }
    create(document_params)
    document_params = {title: "Cloud Computing", author: "Roberto Calderon", doctype: "research paper", category:"cyber security", keywords:"cloud computing", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Ethical%20Hacking%20Group%20Proposal%20Final.pdf"}
    create(document_params)
    document_params = {title: "Hardware and Software security", author: "DaQuan Stevens", doctype: "research paper", category:"cyber security", keywords:"software hardware security", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Hardware%20and%20Software%20Security.pdf"}
    create(document_params)
    document_params = {title: "Pharming", author: "Osvaldo Concepcion", doctype: "research paper", category:"cyber security", keywords:"pharming phishing", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EEL4789_Project.pdf"}
    create(document_params)
    document_params = {title: "Creating Exploits", author: "Mark Bacchus", doctype: "research paper", category:"cyber security", keywords:"exploits", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Creating%20Exploits%20-%20EEL%206931.pdf"}
    create(document_params)
    document_params = {title: "Home Automation Security and Vulnerabilities", author: "Henry Flefel", doctype: "research paper", category:"cyber security", keywords:"home automation security vulnerabilities", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Compiled%20Group%20Paper%20v2.pdf"}
    create(document_params)
=begin
    Document.create(title: "Wifi security : wirless network encryption", author: "Gavin Garcia", doctype: "research paper", category:"cyber security", keywords:"wireless network encryption", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EthicalHackingProject.pdf" )
    Document.create(title: "Software Crackers", author: "Bryan Degro", doctype: "research paper", category:"cyber security", keywords:"cracker hacker", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Researchpaper.pdf" )
    Document.create(title: "Mobile Malware", author: "Alexander Pons", doctype: "research paper", category:"cyber security", keywords:"malware mobile", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Ethical%20Hacking%20final%20paper%202.0.pdf" )
    Document.create(title: "Smart Grid", author: "Oniel Gordon", doctype: "research paper", category:"cyber security", keywords:"smart grid", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Smart%20Grid%20cyber%20physical%20security.pdf" )
    Document.create(title: "The Insights into car hacking", author: "Mark Bacchus", doctype: "research paper", category:"cyber security", keywords:"car hacking", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Car%20Hacking%20-%20eel%206931%20final.pdf" )
    Document.create(title: "Ethical hacking and counter measures", author: "Pons", doctype: "research paper", category:"cyber security", keywords:"ethical hacking", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EthicalHackingFinalDraft5PageProposal.pdf" )
    Document.create(title: "Cloud Computing", author: "Roberto Calderon", doctype: "research paper", category:"cyber security", keywords:"cloud computing", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Ethical%20Hacking%20Group%20Proposal%20Final.pdf" )
    Document.create(ztitle: "Hardware and Software security", author: "DaQuan Stevens", doctype: "research paper", category:"cyber security", keywords:"software hardware security", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Hardware%20and%20Software%20Security.pdf" )
    Document.create(title: "Pharming", author: "Osvaldo Concepcion", doctype: "research paper", category:"cyber security", keywords:"pharming phishing", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EEL4789_Project.pdf" )
    Document.create(title: "Creating Exploits", author: "Mark Bacchus", doctype: "research paper", category:"cyber security", keywords:"exploits", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Creating%20Exploits%20-%20EEL%206931.pdf" )
    Document.create(title: "Home Automation Security and Vulnerabilities", author: "Henry Flefel", doctype: "research paper", category:"cyber security", keywords:"home automation security vulnerabilities", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Compiled%20Group%20Paper%20v2.pdf" )
=end
  end
  def down
    Document.delete_all
  end
end
