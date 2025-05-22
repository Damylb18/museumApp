# CMM Admin

This is a .NET web app and API, making use of an SQLite database. It stores information on museum artificats that will be accessed by the accompanying app. No personal information is stored.
The goal of the part of the project is to make the contents of the app easily modifiable by CMM staff via a user friendly admin panel.

## Deploying
1. Microsoft recommends publishing .NET web apps with Microsoft Azure, but there are other options available if desired. To publish to Azure, follow the .NET publishing documentation.
https://learn.microsoft.com/en-us/visualstudio/deployment/quickstart-deploy-aspnet-web-app - In order to publish to another type of server, follow their instructions.
1. Visit the new URL and login using the default password: humble.flanked.repackage.unpiloted.sulfide
1. Change the default password to something memorable and secure - use modern password guidelines as these can change.
1. (OPTIONAL, RECOMMENDED) Set up two-factor authentication in the account settings menu.
1. Start adding artefacts - they will automatically become availabe to the app after creation. Maximum image size for artefacts is 10MB, but smaller is recommended to avoid large storage demands.
1. Print QR codes for the artefacts and place them around the museum. The QR code can be found in the "Details" page for each artefact, where it can be right clicked and saved as an image. This can be resized as desired - most sizes will work.
