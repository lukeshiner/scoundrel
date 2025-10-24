-- Logging

logfile = "scoundrel"

function log(str)
    printh(str, logfile)
end

printh("STARTUP - Scoundrel", logfile, true)
timestamp = stat(80) .. "/" .. stat(81) .. "/" .. stat(82) .. " - " .. stat(83) .. ":" .. stat(84)
log(timestamp)