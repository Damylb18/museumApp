# Cheshire Military Museum

### Files:

- CMM-App: Flutter app for users
- CMM-Admin: .NET web app and API for museum staff

### This project consists of:

A Flutter app (works with both Android and iOS) where the user can explore the museum and scan QR codes to "collect" artefacts. These collected artefacts show up in a list and the user gains medals depending on how many they have collected, gamifying the experience in order to make it more engaging.

![home](./img/home.jpg){width=160}
![artefacts](./img/artefacts.jpg){width=160}
![medals](./img/medals.jpg){width=160}

An admin panel, intended to allow staff to manage the collection of artefacts and generate QR codes to place around the museum.


### Deployment
1. Deploy the admin panel by following the instructions in the README.md file in the **CMM-Admin** folder.
1. Deploy the app by following the instructions in the README.md file in the **CMM-App** folder.

Some of the app functionality will work without deployment the admin panel (such as the links to the website pages), but the artefact scanning and collection will not be available. This functionality also requires an internet connection.
