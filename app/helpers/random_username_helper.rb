def random_username
  random_string = "#"
  random_string += (0...5).map { (65 + rand(26)).chr }.join
  random_string
end