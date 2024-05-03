# Use a base image that includes Windows and any necessary dependencies
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install SteamCMD
RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Uri https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -OutFile c:\steamcmd.zip; \
    Expand-Archive c:\steamcmd.zip -DestinationPath c:\steamcmd; \
    Remove-Item c:\steamcmd.zip;

# Install Conan Exiles Server
WORKDIR /steamcmd
RUN ./steamcmd.exe +login anonymous +force_install_dir /conan_exiles +app_update 443030 validate +quit

# Copy startup script and configuration files
COPY startup.ps1 /
COPY serverSettings.ini /conan_exiles/ConanSandbox/Config/

# Expose necessary ports
EXPOSE 7777/udp 7778/udp 27015/udp

# Set the command to run the server
CMD ["powershell", "/startup.ps1"]