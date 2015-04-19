local send_after_load_orig = NetworkPeer.send_after_load
local send_queued_sync_orig = NetworkPeer.send_queued_sync

Global.real_armor = {
    "level_8",
    "level_9",
    "level_10",
    "level_11"
}
Global.spoof_armor = {
    "level_6",
    "level_6",
    "level_1",
    "level_7"
}

function NetworkPeer:send_after_load(type, arg1, ...)
    if type == "sync_outfit" then
    	local new_arg, count
        new_arg = arg1
        for i = 1, #Global.real_armor do
            new_arg, count = string.gsub(new_arg, Global.real_armor[i], Global.spoof_armor[i])
        end
        return send_after_load_orig(self, type, new_arg, ...) -- Replace level and rank with the intended spoof option
    end

    return send_after_load_orig(self, type, arg1, ...)
end

function NetworkPeer:send_queued_sync(type, arg1, ...)
    if type == "sync_outfit" then
        local new_arg, count
        new_arg = arg1
        for i = 1, #Global.real_armor do
            new_arg, count = string.gsub(new_arg, Global.real_armor[i], Global.spoof_armor[i])
        end
        return send_queued_sync_orig(self, type, new_arg, ...) -- Replace level and rank with the intended spoof option
    end

    return send_queued_sync_orig(self, type, arg1, ...)
end