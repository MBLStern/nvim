local javaConfig = {
    cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    init_options = {
        bundles = {
            vim.fn.glob(
                "/home/Marius/ManualPackages/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
                true)
        },
    },
    configuration = {
        runtimes = {
            {
                name = "JavaSE-1.8",
                path = "/usr/lib/jvm/java-8-openjdk/",
            },
            {
                name = "JavaSE-17",
                path = "/usr/lib/jvm/java-17-openjdk/",
            },
            {
                name = "JavaSE-23",
                path = "/usr/lib/jvm/java-23-openjdk/",
                default = true,
            },

        }
    },
}
require('jdtls').start_or_attach(javaConfig)
