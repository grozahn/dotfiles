require("vis")

require("plugins/vis-ctags/ctags")
require("plugins/vis-fzf-open/fzf-open")
require("plugins/vis-surround/surround")
require("plugins/vis-title/title")

local INIT_PARAMS = {
    ["theme"]             = "gruvbox",
    ["change-256colors"]  = "on"
}

local PARAMS = {
    ["relativenumbers"]   = "on",
    ["cursorline"]        = "on",
    ["expandtab"]         = "on",
    ["tabwidth"]          = "4",
    ["show-tabs"]         = "off",
    ["autoindent"]        = "on"
}

local function visSetParams(p)
    if p then
        for k, v in pairs(p) do
            vis:command(string.format("set %s %s", k, v))
        end
    end
end

vis.events.subscribe(vis.events.INIT, function()
    -- Your global configuration options
    visSetParams(INIT_PARAMS)
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    visSetParams(PARAMS)
end)
