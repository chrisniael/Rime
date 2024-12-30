-- toggle_ascii.lua

local toggle_ascii = {}

function toggle_ascii.init(env)
    context = env.engine.context
    context.option_update_notifier:connect(function(ctx, name)
        if name == "ascii_mode" and ctx:get_option("ascii_mode") then
            context:clear_non_confirmed_composition()
            context:commit()
        end
    end)
end

return toggle_ascii
