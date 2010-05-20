require "log4r"

# Custom Log4r formatter for files
class FileFormatter < Log4r::BasicFormatter

  def initialize(hash={})
    super(hash)
  end

  def format(logevent)
    if Log4r::LNAMES[logevent.level].eql? "PROGRESS"
      # Formats the data as is with no newline, to allow progress bars to be logged.
      sprintf("%s", logevent.data.to_s)
    else
      if logevent.data.kind_of? String
        # remove ^M characters
        logevent.data.gsub!(/\r/, "")
        # Prevent two newlines in the log file
        logevent.data.chop! if logevent.data =~ /\n$/
      end
      sprintf("[%s %s] %s\n", Log4r::LNAMES[logevent.level], Time.now.strftime("%m/%d/%Y %I:%M:%S %p"), format_object(logevent.data))
    end
  end
end
