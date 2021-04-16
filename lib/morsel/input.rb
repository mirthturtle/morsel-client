class Input

  def self.break; ['q', 'x'] end
  def self.thoughts; '1' end
  def self.melon_selector; '2' end
  def self.animal_commerce; '3' end

  def self.nicole_mode; 'n' end
  def self.nicole_status; '1'  end
  def self.nicole_data; '2'  end

  def self.melon_options; ['1','2','3'] end

  # Get single character input
  def self.get
    begin
      system("stty raw -echo")
      str = STDIN.getc
    ensure
      system("stty -raw echo")
    end
    str
  end

  # grab whole line w/o trailing newline
  def self.read_line
    line = gets.chomp
  end

end
