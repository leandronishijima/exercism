class LogLineParser
  def initialize(line)
    @line = line
  end

  def split_line
    @line.split(':')
  end

  def message
    split_line[1].strip
  end

  def log_level
    split_line[0].gsub(/[\[\]]/, '').downcase
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
