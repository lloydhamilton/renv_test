FROM rocker/shiny:3.6.3

RUN apt-get --allow-releaseinfo-change update
RUN apt-get install --assume-yes libssl-dev libxml2-dev

COPY /app ./app
COPY renv/activate.R renv/activate.R
COPY .Rprofile .Rprofile
COPY renv.lock renv.lock

RUN R -e 'install.packages("renv")'
RUN R -e 'renv::consent(provided = TRUE)'
RUN R -e 'renv::restore()'

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
