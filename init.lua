function Status:name()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end
	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end

	return ui.Span(" " .. h.name .. linked)
end

Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("#6495ED"),
		ui.Span(":"):fg("#87CEFA"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("#6495ED"),
		ui.Span(" "),
	})
end, 500, Status.RIGHT)

Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ui.Line({})
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("#87CEFA")
end, 500, Header.LEFT)

require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})
