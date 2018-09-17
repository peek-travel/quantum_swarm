# QuantumSwarm

This repo is a minimally reproducible test case of a Quantum bug I'm trying to hunt down.

Libraries used:

* distillery for releases
* libcluster for DNS polling based clustering
* quantum for global periodic jobs

Usage:

* Install docker + docker compose
* clone this repo
* run `docker-compose up --build`
* you should see "PING!" message logged to stdout every 3 seconds
* in a separate terminal tab, scale the app using `docker-compose up -d --scale web=3`
* watch the logs, notice if the "PING!" message continue or not

Scaling the app up and down sometimes works, and sometimes doesn't. Try different numbers other than 3 as well, sometimes 3 works, and sometimes it doesn't.
