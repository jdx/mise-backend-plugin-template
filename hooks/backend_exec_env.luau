--!strict
local Types = require("@lib/types")

local plugin = PLUGIN :: Types.PluginType
local file = require("file") :: Types.FileModule

--- Sets up environment variables for a tool
--- Documentation: https://mise.jdx.dev/dev-tools/backends/vfox.html
function plugin:BackendExecEnv(
    ctx: { install_path: string, tool: string, version: string }
): { env_vars: { Types.EnvKeyResult } }
    local install_path: string = ctx.install_path
    local _tool: string = ctx.tool
    local _version: string = ctx.version

    -- Basic PATH setup (most common case)
    local bin_path = file.join_path(install_path, "bin")

    local env_vars: { Types.EnvKeyResult } = {
        -- Add tool's bin directory to PATH
        { key = "PATH", value = bin_path },
    }

    -- Example: Tool-specific environment variables
    --[[
	-- Add tool-specific home directory
	table.insert(env_vars, {
		key = `{_tool:upper()}_HOME`,
		value = install_path
	})

	-- Add version environment variable
	table.insert(env_vars, {
		key = `{_tool:upper()}_VERSION`,
		value = _version
	})

	-- Add configuration directory
	table.insert(env_vars, {
		key = `{_tool:upper()}_CONFIG`,
		value = file.join_path(install_path, "config")
	})
	--]]

    -- Example: Backend-specific paths (like node_modules for npm)
    --[[
	-- For npm-like backends that install to subdirectories
	local modules_bin = file.join_path(install_path, "node_modules", ".bin")
	table.insert(env_vars, {key = "PATH", value = modules_bin})

	-- For Python-like backends with site-packages
	local site_packages = file.join_path(install_path, "lib", "python3.x", "site-packages")
	table.insert(env_vars, {key = "PYTHONPATH", value = site_packages})

	-- For Rust-like backends with cargo binaries
	local cargo_bin = file.join_path(install_path, ".cargo", "bin")
	table.insert(env_vars, {key = "PATH", value = cargo_bin})
	--]]

    -- Example: Library paths for compiled tools
    --[[
	local runtime = RUNTIME :: Types.RuntimeType
	local lib_path = file.join_path(install_path, "lib")
	local lib64_path = file.join_path(install_path, "lib64")

	if runtime.osType == "Linux" then
		table.insert(env_vars, {key = "LD_LIBRARY_PATH", value = lib_path})
		table.insert(env_vars, {key = "LD_LIBRARY_PATH", value = lib64_path})
	elseif runtime.osType == "Darwin" then
		table.insert(env_vars, {key = "DYLD_LIBRARY_PATH", value = lib_path})
	end
	--]]

    -- Example: Include paths for development tools
    --[[
	local include_path = file.join_path(install_path, "include")
	table.insert(env_vars, {key = "C_INCLUDE_PATH", value = include_path})
	table.insert(env_vars, {key = "CPLUS_INCLUDE_PATH", value = include_path})
	--]]

    -- Example: Manual pages path
    --[[
	local man_path = file.join_path(install_path, "share", "man")
	table.insert(env_vars, {key = "MANPATH", value = man_path})
	--]]

    return {
        env_vars = env_vars,
    }
end
