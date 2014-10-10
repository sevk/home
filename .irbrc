#require 'bond'
require 'hirb'

ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

#Bond.start
Hirb.enable
#ActiveRecord::Base.logger.level = 1 # Avoid log in Rails console
