require('rubygems')
require('irb/completion')

require 'hirb'
ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

#$: << 'D:\Jnew\program\rec\lib'
require('map_by_method')
require('what_methods')
require('pp')
require('wirble')
IRB.conf[:AUTO_INDENT] = true
#IRB.conf[:PROMPT_MODE] = :XMP
IRB.conf[:USE_READLINE] = true
Wirble.init
Wirble.colorize

