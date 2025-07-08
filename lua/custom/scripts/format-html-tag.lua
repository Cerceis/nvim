local M = {}

-- This function detects the starting and end tag and formats it
function M.split_html_attributes()
    local line_num = vim.fn.line(".") - 1
    local line = vim.api.nvim_get_current_line()

    local indent = line:match("^(%s*)") or ""

    -- Match opening + attributes + end + closing tag
	local open_tag_full, attr_part, tag_close, content, closing_tag = line:match(
		"^%s*(<[%w%-:]+)(.-)(%s*/?>)(.-)(</[%w%-:]+>)%s*$"
	);

    if not open_tag_full then
        print("No valid tag pair found.")
        return
    end

    -- Extract attributes
    local attrs = {}
    for attr in attr_part:gmatch("%s+[^%s>]+=[\"'][^\"']+[\"']") do
        table.insert(attrs, vim.trim(attr))
    end

    if #attrs == 0 then
        print("No attributes found.")
        return
    end

    -- Construct new lines
    local new_lines = {}
    table.insert(new_lines, indent .. open_tag_full)
    for _, attr in ipairs(attrs) do
        table.insert(new_lines, indent .. "    " .. attr)
    end
    table.insert(new_lines, indent .. tag_close)

	if content ~= "" then
		table.insert(new_lines, indent .. "    " .. content)
	end
	table.insert(new_lines, indent .. closing_tag)

    vim.api.nvim_buf_set_lines(0, line_num, line_num + 1, false, new_lines)
end

-- Unlike the function above, this function can format line only the start tag is present.
function M.split_html_opening_only()
    local line_num = vim.fn.line(".") - 1
    local line = vim.api.nvim_get_current_line()

    local indent = line:match("^(%s*)") or ""

    -- Match just the opening tag (with attributes), e.g. <v-btn prop1="..." prop2="...">
	local tag_start, attr_part = line:match("^%s*(<[%w%-:]+)(.-)%s*>%s*$")
    if not tag_start then
        print("Not a valid opening tag.")
        return
    end

    local attrs = {}
	for attr in attr_part:gmatch('%s+[^%s>]+=["\'][^"\']*["\']') do
        table.insert(attrs, vim.trim(attr))
    end

    if #attrs == 0 then
        print("No attributes found.")
        return
    end

    -- Create new lines
    local new_lines = {}
    table.insert(new_lines, indent .. tag_start)
    for _, attr in ipairs(attrs) do
        table.insert(new_lines, indent .. "    " .. attr)
    end
    table.insert(new_lines, indent .. ">")

    vim.api.nvim_buf_set_lines(0, line_num, line_num + 1, false, new_lines)
end

return M
