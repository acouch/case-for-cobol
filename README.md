# COBOL web app using USWDS

This is an extremely serious attempt to bring COBOL web application development to the government technology community.

This built using the excellent [COBOL on Wheelchair](https://github.com/azac/cobol-on-wheelchair) microframework.

Run `docker compose up` and be blessed with a gov-ready website using USWDS:

<img width="617" height="348" alt="Image" src="https://github.com/user-attachments/assets/3f382dd3-950c-41ca-8f45-84e79e2f1cf1" />

This was built for a presentation "The Case for COBOL":

<a href="https://docs.google.com/presentation/d/1TcWzt-vIvofv2uC_YRX_4WzhEobtKXn6n-BdXlDl_e0/edit?usp=sharing"><img width="1149" height="626" alt="image" src="https://github.com/user-attachments/assets/672bceab-3582-4416-8930-3a59b1c0e247" /></a>


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
