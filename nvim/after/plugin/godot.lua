local setup_godot_dap = function()
    local dap = require("dap")

    dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
    }

    dap.configurations.gdscript = {
        {
            launch_game_instance = false,
            launch_scene = false,
            name = "Launch scene",
            project = "${workspaceFolder}",
            request = "launch",
            type = "godot",
        },
    }
end

--setup_godot_dap()
