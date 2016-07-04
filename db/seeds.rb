all_urls = []

File.open("db/urls", "r+") do |row|
    row.each_line do |long_url|
      long_url.gsub!(",\n","")
      long_url.gsub!("(","")
      long_url.gsub!(")","")
      long_url.gsub!(",","")
      long_url.gsub!(";","")

      short_url = rand(36**rand(5..8)).to_s(36)

      urls = "'#{long_url}', '#{short_url}'"
      all_urls << urls
    end
end

Url.transaction do
  all_urls.each do |data|
    Url.connection.execute "INSERT INTO urls (long_url, short_url) VALUES (#{data})"
  end
end