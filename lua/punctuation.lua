local punctuation = {}

function punctuation.init(env)
end

function punctuation.fini(env)
end

function punctuation.func(key, env)
    -- return 0,1,2
    -- 0拒绝，librime不做处理
    -- 1接受，仅本processor处理
    -- 2跳过，本processor不做处理

    -- 如果是按键释放事件，不处理
    if key:release() then
        return 2
    end

    -- 如果有 Ctrl, Alt, Super 键按下，不处理
    if key:ctrl() or key:alt() or key:super() then
        return 2
    end

    local context = env.engine.context

    -- 如果正在输入拼音或英文模式，不做处理
    if context:is_composing() or context:get_option("ascii_mode") then
        return 2
    end

    local keycode = key.keycode
    local modifier = key.modifier
    -- 半角标点符号对应全角符号
    local char = {
        [46] = "。",  -- 半角句号 -> 全角句号
        [58] = "：",  -- 半角冒号 -> 全角冒号
        -- [44] = "，"   -- 半角逗号 -> 全角逗号
    }

    -- log.info("Key code: " .. tostring(keycode))
    -- log.info("modifier: " .. tostring(modifier))
    

    -- 如果按键是定义的标点符号
    if char[keycode] then
        -- 获取最后一个提交的字符
        local last_ch = context.commit_history:back()
        
        -- 如果最后一个字符是数字
        if last_ch and last_ch.text:match("%d$") then
            -- 提交全角标点符号
            env.engine:commit_text(char[keycode])
            -- 清空当前拼音状态
            context:clear()
            return 1
        end
    end

    -- 默认跳过此事件
    return 2
end

return punctuation
