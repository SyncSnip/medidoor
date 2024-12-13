# Medidoor Backend

![Medidoor Logo](https://via.placeholder.com/150) <!-- Replace with your project logo -->

## Description

Medidoor is a powerful backend API built with Node.js, Express, and Prisma. It provides a robust platform for managing users and products with features like user authentication, data validation, and error handling.

## Table of Contents

- [Medidoor Backend](#medidoor-backend)
  - [Description](#description)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Response Codes](#response-codes)
  - [Apply database migrations:](#apply-database-migrations)
  - [Apply any changes in database:](#apply-any-changes-in-database)
  - [Run Backend](#run-backend)

## Features

- User management (signup, signin, update, delete)
- Product management (get all products)
- Secure password handling with bcrypt
- JWT authentication for secure access
- Prisma ORM for database interactions

## Response Codes

 - 200 OK: Successfully retrieved data.
 - 201 Created: Successfully created a resource.
 - 403 Forbidden: Unauthorized user access.
 - 404 Not Found: Resource not found.
 - 500 Internal Server Error: Server encountered an error.

## Apply database migrations:
`npx prisma migrate dev`

## Apply any changes in database:
`npx prisma migrate dev --name make_isVerified_required`

## Run Backend
`nodemon server.js`