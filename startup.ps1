# Check if database backup exists and restore it
if (Test-Path "/backup/game.db") {
    Copy-Item "/backup/game.db" "/conan_exiles/ConanSandbox/Saved/"
}

# Download and update mods (this will need custom handling depending on your mod management strategy)
# Example: Invoke-WebRequest for mod files or use a third-party mod manager that supports command line

# Start the server
./conan_exiles/ConanSandboxServer.exe -log