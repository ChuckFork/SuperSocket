#!/bin/sh
echo "Changing to /src directory..."
cd src
echo "Executing MSBuild DLL begin command..."
dotnet ../tools/sonar/SonarScanner.MSBuild.dll begin /o:"chuckfork" /k:"ChuckFork_SuperSocket" /d:sonar.cs.vstest.reportsPaths="**/TestResults/*.trx" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.verbose=false /d:sonar.login=${SONAR_TOKEN}
echo "Running build..."
dotnet build ../SuperSocket.sln
echo "Running tests..."
dotnet test ../test/SuperSocket.Tests/SuperSocket.Tests.csproj --logger:trx
echo "Executing MSBuild DLL end command..."
dotnet ../tools/sonar/SonarScanner.MSBuild.dll end /d:sonar.login=${SONAR_TOKEN}