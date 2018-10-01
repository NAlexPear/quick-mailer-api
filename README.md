# quick-mailer-api

### An example project for setting up Rails as a JSON API with an ActiveMailer queue


## Summary

This project is meant as a proof-of-concept for a completely stand-alone Rails-based mail service. The goals of this project:

1. __Rails integration__: the same tools, conventions, and data structures used in a Rails monolith are present here to improve Rails-app-to-Rails-app communication.
2. __HTTP interaction__: this API should be organized as a Rails app, but exist independently, with mail jobs initialited through service-agnostic `POST` requests.
3. __Job resilience__: the queue of jobs should survive application crashes or restarts. This is accomplished through the use of Sidekiq and Redis.
4. __Error handling__: Network errors and SMTP errors should be raised, handled, and filtered by type, accessible by other applications through the API itself for handling by other services as necessary. The error state of a particular job should not affect the rest of the queue.

Not included in this design:

1. __Authentication of any kind__. This could be handled at the infrastructure level, or this API could be integrated directly with an existing autheticated Rails application, or this API could be augmented to handle authentication through tokens in each request.
2. __Views/Client-side interactions__. This API is meant to serve all kinds of apps (although maps well to interaction with Rails-based APIs)
3. __Production infrastructure configuration__. `docker-compose.yaml` is configured here for dev convenience only. Do _not_ use this configuration in production!
4. __Granular Error Handling__. Eventually, one would want to assign different types of `Error`s to different types of exceptions. Since this is a proof-of-concept, all errors are assumed to be `:network` errors.
5. __Inter-changeable Mail Service Adapters__. This version ships with Mailgun integration through the `mailgun_rails` gem. With a bit more effort, any other provider (SMTP or otherwise) would be able to be plugged in.
6. __Richer Error Types__: currently, errors are defined by their failure. In the future, these should include messages, times, etc.

## Installation

The only dependencies for this project are Docker and `docker-compose`. Assuming both are installed, starting the application is as simple as:

1. creating an `.env` file that includes a `DEFAULT_USER` and `DOMAIN_NAME` for your email account, as well as a `MAILGUN_API_KEY` if you're using Mailgun. It's also recommended that you add a `RAILS_ENV` of `development`.
2. running `docker-compose up`
3. accessing the `/messages`, `/messages/:id`, `/errors`, and `/errors?type=:type` routes on `localhost:3000`

## Usage

All messages are generated through a `POST` to the `/messages` endpoint. Send an `email`, `name`, and `subject`, and the job will be queued up for delivery asynchronously through Sidekiq. In the event that something goes wrong, future queries of `/message/:id` will include an associated `error_id` with more information.

The idea is that this service will be used by other services to periodically prune a list of users, names, or subscriber lists by the nature of associated errors.
