# quick-mailer-api

### An example project for setting up Rails as a JSON API with an ActiveMailer queue


## Summary

This project is meant as a proof-of-concept for a completely stand-alone Rails-based mail service. The goals of this project:

1. __Rails integration__: the same tools, conventions, and data structures used in a Rails monolith are present here to improve Rails-app-to-Rails-app communication.
2. __HTTP interaction__: this API should be organized as a Rails app, but exist independently, with mail jobs initialited through service-agnostic `POST` requests.
3. __Job resilience__: the queue of jobs should survive application crashes or restarts. This is accomplished through the use of Sidekiq and Redis.
4. __Error handling__: Network errors and SMTP errors should be raised, handled, and logged separately, accessible by other applications through the API itself for handling by other services as necessary. The error state of a particular job should not affect the rest of the queue.

Not included in this design:

1. __Authentication of any kind__. This could be handled at the infrastructure level, or this API could be integrated directly with an existing autheticated Rails application, or this API could be augmented to handle authentication through tokens in each request.
2. __Views/Client-side interactions__. This API is meant to serve all kinds of apps (although maps well to interaction with Rails-based APIs)
3. __Production infrastructure configuration__. `docker-compose.yaml` is configured here for dev convenience only. Do _not_ use this configuration in production!

