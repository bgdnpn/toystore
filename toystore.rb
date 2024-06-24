require "./utils/utils.rb"

class ToyStore

  attr_reader :rows
  attr_reader :persistence_path
  attr_reader :persistence_file

  def initialize(persist_to=nil)
    # initialize with a fresh and empty array
    @rows = {}
    
    # initiate persistence layer if path is provided
    if persist_to != nil
      @persistence_path = persist_to
      begin
        @persistence_file = open_if_exists(persist_to)
        ingest_file_contents()
      rescue Exception => e
        puts e.message
      end
    end 
  end

  def read(key)
    # read a row at a time
    @rows[key]
  end

  def upsert(key, value)
    # update or insert a key-value pair
    if @rows.key?(key) then
      log "Updating existing key.", "orange"
    end
    @rows[key] = value
  end

  def delete(key)
    # delete k-v pair
    @rows.delete(key)
  end

  def ingest_file_contents()
    # ingest file into memory 
    @persistence_file.each do |line|
      key, value = line.strip.split(" ~ ")
      self.upsert(key, value)
    end
  end

  def persist(obj)
    # write k-v object to file (is this the right way to do it?! probably not)
    formatted_obj = to_file_format(obj)
    write_to_file(@persistence_file, formatted_obj)
  end

end
