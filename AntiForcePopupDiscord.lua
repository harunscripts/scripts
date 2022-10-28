local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local old
old = hookfunction(httprequest, newcclosure(function(...)
    local args = {...}
    if typeof(args[1]) == "table" then
        if args[1].Url:find("http://127.0.0.1:6463") then
            return nil
        end
    end
    return old(...)
end))
