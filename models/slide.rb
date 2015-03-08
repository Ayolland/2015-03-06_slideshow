class Slide
  
  attr_accessor :title, :body, :id, :stack
  
  def initialize(options)
    binding.pry
    @title  = options[:title] || options["title"]
    @body   = options[:body]  || options["body"]
    @stack  = options[:stack] || options["stack"]
    @id     = options[:id]    || options["id"]
  end
  
  def self.find(id) #Returns a single Slide object
    Slide.new(DATABASE.execute("SELECT * FROM slides WHERE id = #{id}")[0])
  end
  
  def self.all #Returns an array of Slide objects
    results = DATABASE.execute("SELECT * FROM slides")
    results.map { |hash| Slide.new(hash) }
  end
  
  def next #returns the next slide object
    results = DATABASE.execute("SELECT * FROM slides WHERE stack > #{@stack}")
    Slide.new(results[0])  || Slide.all[0]
  end
  
  def previous #returns the previous slide object
    results = DATABASE.execute("SELECT * FROM slides WHERE stack < #{@stack}")
    Slide.new(results.pop)  || Slide.all.pop
  end
  
  def insert #Adds a Slide object into the database if the @id is nil
    if @id == nil
      DATABASE.execute("INSERT into slides (title,body,stack) VALUES (#{@title},#{@body},#{@stack})")
      @id = DATABASE.last_insert_row_id
    end
  end
  
  def save #Saves changes to a slide object. Checks for a valid id.
    if DATABASE.execute("SELECT * FROM slides WHERE id = #{@id}")[0]
      DATABASE.execute("UPDATE slides SET title = #{@title}, body = #{@body}, stack = #{@stack} WHERE id = #{@id}")
    end
  end
  
  def delete #deletes the current slide from the database
    DATABASE.execute("DELETE FROM slides WHERE id = #{@id}")
  end
  
  def to_hash #returns a converted hash
    {
      id: id,
      title: title,
      body: body,
      stack: stack,
    }
  end
  
end