# Golang Project Scaffolding

This repository is a starter pack for Golang projects.  The gist is that package X holds some important runtime variables that can be used to identify the final go binary.  The Makefile is responsible for injecting these identifiers into the build via LDFlags.  Vet, Test, and a TLS cert generating is also included as steps.  OpenSSL is required for cert generation.