local M = {}

-- Function to get git diff --cached
local function get_git_diff_cached()
  local handle = io.popen("git diff --cached")
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Function to generate a conventional commit message
local function generate_commit_message(diff)
  local message = ""
  local added, modified, deleted = 0, 0, 0

  for line in diff:gmatch("[^\r\n]+") do
    if line:match("^%+[^%+]") then
      added = added + 1
    elseif line:match("^%-[^%-]") then
      deleted = deleted + 1
    elseif line:match("^diff") then
      modified = modified + 1
    end
  end

  if added > 0 then
    message = message .. "feat: add new features\n"
  end
  if modified > 0 then
    message = message .. "fix: modify existing features\n"
  end
  if deleted > 0 then
    message = message .. "chore: remove features\n"
  end

  message = message .. "\n" .. diff
  return message
end

-- Function to commit changes using conventional commits
function M.commit_changes()
  local diff = get_git_diff_cached()
  if diff == "" then
    print("No changes to commit.")
    return
  end

  local commit_message = generate_commit_message(diff)
  os.execute('git commit -m "' .. commit_message .. '"')
end

return M
