FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["TCountApp.csproj", "."]
RUN dotnet restore "./TCountApp.csproj"
COPY . .
RUN dotnet publish "TCountApp.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "TCountApp.dll"]
