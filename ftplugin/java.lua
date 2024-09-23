local javaConfig = {
    cmd = { '/usr/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    init_options = {
        bundles = {
            vim.fn.glob(
                "/home/Marius/ManualPackages/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
                true)
        },
    }
}
require('jdtls').start_or_attach(javaConfig)
