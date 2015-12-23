-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Load Debian menu entries
--require("debian.menu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end


-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
function x(s)
  a = os.execute("which "..s )
  print (s.." : " .. a)
  if a == 0 then return a else return 1 end
end

t = "terminal"
if x(t) == 0 then
  terminal = t
elseif x("xfce4-terminal") then
  terminal = "xfce4-terminal"
else
  cmd = "ruby /home/kk/dotfiles/term.rb"
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a')) 
  f:close() 
  terminal = s
end

function ruby1(cmd)
  cmd = "ruby " .. cmd
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a')) 
  f:close() 
  print (s)
end

editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

--os.execute("/usr/bin/gnome-keyring-daemon --start --components=gpg & ")
function start_daemon(dae)
  daeCheck = os.execute("ps -eF | grep -v grep | grep -w " .. dae)
  if (daeCheck ~= 0) then
    os.execute(dae .. " &")
  end
end

-- Default altkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
winkey = "Mod4" -- use Win key
altkey = "Mod1" -- use Alt key

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    --{ "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ altkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ altkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

www="chromium-browser"
-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ altkey , "Control"}, "0", function () awful.util.spawn("rdesktop -r clipboard:CLIPBOARD -r disk:aa=/tmp/RDP -K -z -a 15 -0 -u r -p2345 192.168.1.80 -g 86%") end),
    awful.key({ altkey , "Control"}, "2", function () awful.util.spawn("rdesktop -r clipboard:CLIPBOARD -r disk:aa=/tmp/RDP -K -z -a 15 -u r -p234 192.168.1.82 -g 80%") end),
    awful.key({ altkey , "Control"}, "4", function () awful.util.spawn("rdesktop -r clipboard:CLIPBOARD -r disk:aa=/tmp/RDP -K -z -a 15 -u r -pcy84.r 192.168.1.84 -g 80%") end),
    awful.key({ altkey , "Control"}, "9", function () awful.util.spawn("rdesktop -r clipboard:CLIPBOARD  -r disk:aa=/tmp/RDP -K -z -a 15 -u administrator -pgqhbj.123 42.6.41.241:10004 -g 86%  ") end),

    awful.key({ winkey }, "t",   function () awful.util.spawn(terminal) end),
    awful.key({ winkey }, "w", function () awful.util.spawn(www) end),
    awful.key({ altkey , "Control"}, "w", function () awful.util.spawn(www) end),
    awful.key({ winkey }, "v", function () awful.util.spawn("virtualbox") end),
    awful.key({ altkey, "Control" }, "v", function () awful.util.spawn("virtualbox") end),
    awful.key({ winkey }, "d", function () awful.util.spawn("stardict") end),
    awful.key({ altkey, "Control" }, "d", function () awful.util.spawn("stardict") end),

    awful.key({ winkey }, "e", function () awful.util.spawn("spacefm") end),
    awful.key({ altkey, "Control" }, "e", function () awful.util.spawn("spacefm") end),

    awful.key({ altkey, "Control" }, "m",function ()
      awful.util.spawn_with_shell("/home/kk/dotfiles/m.rb")
    end),
    -- own key
    awful.key({}, "Print", function()
      awful.util.spawn("/home/kk/dotfiles/zscreen.sh")
      --awful.util.spawn_with_shell("/home/kk/dev/Scrot-and-imgur-zenity-GUI/src/zscreen.sh")
    end),
    awful.key({}, "XF86HomePage", function()
      awful.util.spawn_with_shell("google-chrome")
    end),

    awful.key({}, "XF86AudioMute", function()
      awful.util.spawn_with_shell("/home/kk/dotfiles/m.rb")
    end),

    -- 107 is Print
    awful.key({ "Shift" }, "Print" , 
    function () 
          --awful.util.spawn("scrot -sb -e 'mv $f /tmp/ ' ") 
          --os.execute("scrot -sb -e 'mv $f /tmp/ ' & ")
          naughty.notify({ title="Screenshot", text="The full screen captured" })
        end),

    --awful.key({ altkey,           }, "Left",   awful.tag.viewprev       ),
    --awful.key({ altkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ altkey, "Control" }, "Escape", awful.tag.history.restore),

    --amixer sset Master toggle
    --awful.key({ "Shift" }, "#" .. 21 + 0x39,  --加0x39变成 f1~f9 , alt+1另有用 
        --function () 
          --os.execute("amixer sset Master toggle &")
          --naughty.notify({ title="un mute", text="mute / unmute" })
        --end),

    --
    --awful.key({ altkey,           }, "j",
        --function ()
            --awful.client.focus.byidx( 1)
            --if client.focus then client.focus:raise() end
        --end),
    --awful.key({ altkey,           }, "k",
        --function ()
            --awful.client.focus.byidx(-1)
            --if client.focus then client.focus:raise() end
        --end),

    --awful.key({ altkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    --awful.key({ altkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    --awful.key({ altkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),

    awful.key({ altkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ altkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    --awful.key({ altkey,           }, "u", awful.client.urgent.jumpto),

    awful.key({ altkey,           }, "j",
    function ()
      -- awful.client.focus.history.previous()
      awful.client.focus.byidx(1)
      if client.focus then
        client.focus:raise()
      end
    end),

    --awful.key({ "Control",           }, "Tab",
    --function ()
      ---- awful.client.focus.history.previous()
      --awful.client.focus.byidx(-1)
      --if client.focus then
        --client.focus:raise()
      --end
    --end),
    
    awful.key({ altkey,           }, "k",
    function ()
      -- awful.client.focus.history.previous()
      awful.client.focus.byidx(-1)
      if client.focus then
        client.focus:raise()
      end
    end),
    --awful.key({ altkey,           }, "Tab",
    --function ()
    --awful.client.focus.history.previous()
    --if client.focus then
                --client.focus:raise()
            --end
        --end),

    -- Standard program
    --awful.key({ altkey,           }, "Return", function () awful.util.spawn(terminal) end),
    --awful.key({ altkey, "Shift"  }, "r", awesome.restart),
    --awful.key({ "Mod1","Control",  "Shift"  }, "q", awesome.quit),

    --awful.key({ altkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    --awful.key({ altkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ altkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ winkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ altkey, "Control"  }, "r",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ altkey, "Control" }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ altkey, "Control" }, "q",      function (c) c:kill()                         end),
    awful.key({ altkey, "Shift" }, "f",  awful.client.floating.toggle                     ),
    awful.key({ altkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ altkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ altkey, "Control" }, "t",   function () awful.util.spawn(terminal) end),
    awful.key({ altkey, "Shift" }, "t",      function (c) c.ontop = not c.ontop            end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

mytagbox = widget({ type = "textbox" })
screen[1]:add_signal("tag::history::update", function()
  mytagbox.text = awful.tag.selected(1).name
end);

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,        
        awful.key({ altkey }, "#" .. i + 9 + 0x39,  --加0x39变成 f1~f9 , alt+1另有用
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),

        awful.key({ altkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ altkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ altkey }, 1, awful.mouse.client.move),
    awful.button({ altkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Private rules
    -- Set Firefox to always map on tags number 2 of screen 1.
    --{ rule = { },
      --properties = { size_hints_honor = false } },
    --{ rule = { class = "Firefox" },
      --properties = { tag = tags[1][1] } },
    --{ rule = { class = "VirtualBox" },
      --properties = { tag = tags[1][3] } },
    { rule = { class = "oclock" },
      properties = { ontop = true }},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { altkey = altkey })

    -- Enable sloppy focus
    --c:add_signal("mouse::enter", function(c)
        --if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            --and awful.client.focus.filter(c) then
            --client.focus = c
        --end
    --end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

local xrun_now = function(name, cmd)
   -- Try first the list of clients from awesome (which is available
   -- only if awesome has fully started, therefore, this function
   -- should be run inside a 0 timer)
   local squid = { name, name:sub(1,1):upper() .. name:sub(2) }
   if awful.client.cycle(
      function(c)
	 return awful.rules.match_any(c,
				      { name = squid,
					class = squid,
					instance = squid })
      end)() then
      return
   end

   -- Not found, let's check with xwininfo. We can only check name but
   -- we can catch application without a window...
   if os.execute("xwininfo -name '" .. name .. "' > /dev/null 2> /dev/null") == 0 then
      return
   end
   awful.util.spawn_with_shell(cmd or name)
end

-- Run a command if not already running.
xrun = function(name, cmd)
   -- We need to wait for awesome to be ready. Hence the timer.
   local stimer = timer { timeout = 0 }
   local run = function()
      stimer:stop()
      xrun_now(name, cmd)
   end
   stimer:add_signal("timeout", run)
   stimer:start()
end

function run_once1(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end
    if not pname then
       pname = prg
    end

    if not arg_string then 
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end
--run_once("xscreensaver","-no-splash")
--run_once("gnome-screensaver",nil) -- err
--run_once("pidgin",nil,nil,2)
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end
--run_once("xpad")
--run_once("chromium-browser")
--xrun("imwheel -k")
--run_once("xfce4-notes")
--run_once("chromium-browser")
run_once("xload")
run_once("clipit")
run_once("volumeicon")
xrun("my_start.rb")
--run_once("oclock")
--run_once("chromium-browser&")
--run_once("stardict")
--xrun("fcitx -d&")
procs = {"gnome-settings-daemon", "nm-applet",  "gnome-sound-applet", "gnome-power-manager"}

--for k = 1, #procs do
  --start_daemon(procs[k])
--end
--xrandr --output DP3 --off --output DP2 --off --output DP1 
----off --output HDMI3 --off --output HDMI2 --off --output 
--HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x256 
----rotate normal --output VGA1 --mode 1280x1024 --pos 1366x0 
----rotate normal   imtxc 
--


-- }}}

naughty.notify({ title = "ok", text = " test start up ok", timeout = 0 })


