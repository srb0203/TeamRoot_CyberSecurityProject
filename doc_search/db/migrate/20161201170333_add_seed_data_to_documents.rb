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
    document_params = { title: "Wifi Security : Wirless Network Encryption", author: "Gavin Garcia", 
      doctype: "Research Paper", category:"Cyber Security", keywords:"wireless network encryption", 
      pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EthicalHackingProject.pdf" }
    create(document_params)

    document_params = {title: "Software Crackers", author: "Bryan Degro", doctype: "Research Paper",
     category:"Cyber Security", keywords:"Cracker Hacker", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Researchpaper.pdf" }        
    create(document_params)

    document_params = {title: "Mobile Malware", author: "Alexander Pons", doctype: "Research Paper",
     category:"Cyber Security", keywords:"Malware Mobile", 
     pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Ethical%20Hacking%20final%20paper%202.0.pdf"}
    create(document_params)

    document_params = {title: "Smart Grid", author: "Oniel Gordon", doctype: "Research Paper",
     category:"Cyber Security", keywords:"Smart Grid", 
     pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Smart%20Grid%20cyber%20physical%20security.pdf" }
    create(document_params)

    document_params = {title: "The Insights Into Car Hacking", author: "Mark Bacchus",
     doctype: "Research Paper", category:"Cyber Security", keywords:"car hacking",
      pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Car%20Hacking%20-%20eel%206931%20final.pdf"}
    create(document_params)

    document_params = {title: "Ethical Hacking And Counter Measures", author: "Pons",
     doctype: "Research Paper", category:"Cyber Security", keywords:"ethical hacking",
      pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EthicalHackingFinalDraft5PageProposal.pdf" }
    create(document_params)

    document_params = {title: "Cloud Computing", author: "Roberto Calderon",
     doctype: "Research Paper", category:"Cyber Security", keywords:"cloud computing",
      pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Ethical%20Hacking%20Group%20Proposal%20Final.pdf"}
    create(document_params)

    document_params = {title: "Hardware And Software Security", author: "DaQuan Stevens", doctype: "Research Paper",
     category:"Cyber Security", keywords:"software hardware security",
      pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Hardware%20and%20Software%20Security.pdf"}
    create(document_params)

    document_params = {title: "Pharming", author: "Osvaldo Concepcion", doctype: "Research Paper",
     category:"Cyber Security", keywords:"pharming phishing", pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EEL4789_Project.pdf"}
    create(document_params)

    document_params = {title: "Creating Exploits", author: "Mark Bacchus", doctype: "Research Paper",
     category:"Cyber Security", keywords:"exploits",
     pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Creating%20Exploits%20-%20EEL%206931.pdf"}
    create(document_params)

    document_params = {title: "Home Automation Security And Vulnerabilities", author: "Henry Flefel",
     doctype: "Research Paper", category:"Cyber Security", keywords:"home automation security vulnerabilities",
      pdflink:"http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/Compiled%20Group%20Paper%20v2.pdf"}
    create(document_params)

    document_params = {title: "A Survey Of Insider Attack Detection Research", author: "Malek Ben Salem",
     doctype: "Research Paper", category:"Cyber Security", keywords:"insider attack",
      pdflink:"https://static-content.springer.com/lookinside/chp%3A10.1007%2F978-0-387-77322-3_5/000.png"}
    create(document_params)

    document_params = {title: "Cyber Security Of Smart Grid Communications: Risk Analysis And Experimental Testing",
     author: "Giovanna Dondassola", doctype: "Research Paper", category:"Cyber Security",
      keywords:"smart grid cyber security", pdflink:"https://static-content.springer.com/lookinside/chp%3A10.1007%2F978-3-662-45928-7_7/000.png"}
    create(document_params)
  end
  def down
    Document.delete_all
  end
end
