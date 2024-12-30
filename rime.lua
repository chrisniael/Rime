-- 两个短横杆代表 lua 的注释行

-- 翻译器：自动转换日期时间
function date_translator(input, seg)
	if (input == "date") then
		--- Candidate(type, start, end, text, comment)
		yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "日期"))
	end
end

toggle_ascii = require("toggle_ascii")
