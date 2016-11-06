class Document < ActiveRecord::Base
  before_save(:on => :create) do
    file_names = ['GeneratedText/Download.txt']
    file_names.each do |file_name|
      text = File.read(file_name)
      new_contents = text.gsub(/[^0-9A-Za-z ]/, '')

      # To write changes to the file, use:
      File.open('GeneratedText/Parsed_Doc.txt', "w") {|file| file.puts new_contents }
      self.keywords = new_contents;
    end
  end
end
