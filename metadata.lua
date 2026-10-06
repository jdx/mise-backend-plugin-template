-- metadata.lua
-- Backend plugin metadata and configuration
-- Documentation: https://mise.jdx.dev/backend-plugin-development.html

PLUGIN = { -- luacheck: ignore
    -- Required: Plugin metadata name
    name = "<BACKEND>",

    -- Required: Plugin metadata version
    version = "1.0.0",

    -- Optional: Plugin description
    description = "A mise backend plugin for <BACKEND> tools",

    -- Optional: Plugin author
    author = "<GITHUB_USER>",

    -- Optional: License name
    license = "MIT",

    -- Optional: Plugin homepage
    homepage = "https://github.com/<GITHUB_USER>/<BACKEND>",

    -- Optional: Legacy version files this plugin can parse
    -- legacyFilenames = {
    --     ".<BACKEND>-version",
    --     ".<BACKEND>rc",
    -- },

    -- Optional: configured mise tools to add to install-hook PATH
    -- depends = { "node" },
}
