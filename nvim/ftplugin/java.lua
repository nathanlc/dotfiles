local lsp_config = require('plugins/lsp-config')
local home = os.getenv('HOME')
local java_home = os.getenv('JAVA_HOME')
local jdtls_path = home .. '/sandbox/apps/java_related/jdtls'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t') -- '/path/to/unique/per/project/workspace/folder'
local jdtls_workspace_dir = home .. '/sandbox/apps/java_related/jdtls_workspace/' .. project_name

-- For this to work, the gradle version must be compatible with the jdk version or something...
-- gradle/wrapper/gradle-wrapper.properties distributionUrl may need to be updated

local config = {
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        java_home .. '/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', jdtls_path .. '/config_mac',
        -- See `data directory configuration` section in the README
        '-data', jdtls_workspace_dir
    },
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
        }
    },

    capabilities = lsp_config.capabilities,
    on_attach = function(client, bufnr)
        -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        lsp_config.on_attach(client, bufnr)
        require('jdtls.setup').add_commands()
    end,

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },
}

require('jdtls').start_or_attach(config)
