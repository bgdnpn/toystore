require 'rainbow/refinement'
using Rainbow

def populate_with_random_data(destination, volume=5)
  1.upto(volume) do |n|
    destination.upsert(n, generate_unique())
  end
end

def generate_unique(up_to=1000)
  random_number = rand(up_to)
  return random_number.to_s
end

def to_file_format(obj)
  return "#{obj[0]} ~ #{obj[1]}"
end

def log(message, color = "white")
  puts Rainbow(message).send(color)
end

# File operations

def open_if_exists(path)
  File.new(path, "a+")
end

def write_to_file(file, line)
  file.puts(line)
end

def close_file(f)
  f.close()
end
