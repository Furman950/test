FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS base
WORKDIR /app
EXPOSE 5585

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /src
COPY ["testWebAppReact/testWebAppReact.csproj", "testWebAppReact/"]
ENV ASPNETCORE_URLS=http://+:5585
RUN dotnet restore "testWebAppReact/testWebAppReact.csproj"
WORKDIR /src/testWebAppReact
COPY testWebAppReact .

RUN apt-get update -yq && apt-get upgrade -yq
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm install 

RUN dotnet build "testWebAppReact.csproj" -c Release -r linux-arm -o /app


FROM build AS publish
RUN dotnet publish "testWebAppReact.csproj" -c Release -r linux-arm -o /app

FROM base AS final
ENV ASPNETCORE_URLS=http://+:5585
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "testWebAppReact.dll"]
