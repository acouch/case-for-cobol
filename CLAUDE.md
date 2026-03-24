# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is **COBOL on Wheelchair (CoW)** — a micro web framework for COBOL that runs CGI scripts via Apache. The app is a COBOL CGI binary served by Apache, with URL routing, parameter extraction, and a simple template engine.

## Build & Run

**Build the COBOL application (inside Docker or on a system with `open-cobol`/`gnucobol`):**
```sh
cd app
./downhill.sh
```
This compiles `cow.cbl`, `cowtemplate.cbl`, and all files in `controllers/` into a single executable `the.cow`.

**Run with Docker Compose (recommended):**
```sh
docker-compose up
```
App is available at http://localhost:8080

**Compile a standalone COBOL program manually:**
```sh
cobc -Wall -x -free <file.cbl> -o <output>
```

**Compile and run immediately:**
```sh
cobc -Wall -x -free -j <file.cbl>
```

**Syntax check only:**
```sh
cobc -fsyntax-only <file.cbl>
```

## Architecture

### Request Flow
1. Apache receives HTTP requests and rewrites all paths to `the.cow` (via `.htaccess`)
2. `the.cow` is the compiled CGI binary (entrypoint: `cow` program in `cow.cbl`)
3. `cow` reads `PATH_INFO` from CGI environment variables via the `getquery` subprogram
4. Routes are defined in `config.cbl` (COPYed into `cow.cbl`) as a routing table
5. The `checkquery` subprogram matches the request path against route patterns (e.g. `/showsum/%value1/%value2`), where `%name` segments are captured as named parameters
6. The matching controller (COBOL program) is called dynamically via `CALL routing-destiny(ctr)`
7. Controllers call `cowtemplate` with a variable list and a `.cow` template filename
8. `cowtemplate` reads the template from `views/`, substitutes `{{varname}}` placeholders, and DISPLAYs the result as HTML

### Key Files
- `app/cow.cbl` — Framework core: CGI entry point, URL dispatcher, `getquery`, `showvars`, `checkquery` subprograms (all compiled as nested programs)
- `app/cowtemplate.cbl` — Template engine: reads `.cow` files, substitutes `{{varname}}` tokens with provided values
- `app/config.cbl` — Route table: `COPY`ed into `cow.cbl`; defines number of routes and pattern→controller mappings
- `app/downhill.sh` — Build script; compiles everything into `app/the.cow`
- `app/controllers/*.cbl` — One COBOL program per route handler; receives captured URL parameters and calls `cowtemplate`
- `app/views/*.cow` — HTML templates with `{{varname}}` placeholders

### Source Formats
- `cow.cbl` and `cowtemplate.cbl` use **fixed-format** COBOL (columns matter; area A/B rules apply)
- `downhill.sh` passes `-free` flag to `cobc`, enabling free-form source format for all compiled files
- The `api/` directory contains standalone experimental COBOL programs (not part of the web app)

### Adding a New Route
1. Add an entry to `app/config.cbl` (increment `nroutes`, add pattern + program-id)
2. Create `app/controllers/<name>.cbl` with a matching `PROGRAM-ID`
3. Optionally create `app/views/<name>.cow` for the HTML template
4. Rebuild with `./downhill.sh`

### Variable Passing Convention
Controllers receive URL parameters as a `LINKAGE SECTION` structure of 10 `query-values` (each with `query-value-name` and `query-value`, both `PIC X(90)`). To pass values to templates, controllers populate a `COW-vars` table (up to 99 entries of `COW-varname`/`COW-varvalue`, both `PIC X(99)`) and call `cowtemplate`.
