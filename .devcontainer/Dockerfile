FROM mcr.microsoft.com/devcontainers/dotnet:8.0

# Install Node.js + npm + Angular CLI
RUN apt-get update \
    && apt-get install -y curl gnupg ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g @angular/cli --unsafe-perm=true

# Install MSSQL Tools
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list -o /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 unixodbc-dev

ENV PATH="$PATH:/opt/mssql-tools18/bin"
USER vscode

