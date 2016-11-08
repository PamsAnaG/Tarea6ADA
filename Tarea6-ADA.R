paquetes<-c("R.utils")

for( paquete in paquetes ){
	if (!require(paquete, character.only=T, quietly=T)) {
		install.packages(paquete)
		library(paquete)
	}
}

setwd("/Users/pamela.gutierrez/Proyectos/R/Tarea6")
dirDescarga<-"/Users/pamela.gutierrez/Proyectos/R/Tarea6/descarga"
dirDatos<-"/Users/pamela.gutierrez/Proyectos/R/Tarea6/datos"

if( !file.exists(dirDescarga) ) {
  dir.create(file.path(dirDescarga), recursive=TRUE) 
  if( !dir.exists(dirDescarga) ) {
    stop("No existe directorio")
  }
}

if( !file.exists(dirDatos) ) {
  dir.create(file.path(dirDatos), recursive=TRUE) 
  if( !dir.exists(dirDatos) ) {
    stop("No existe directorio")
  }
}


archivosDescarga <- c("StormEvents_fatalities-ftp_v1.0_d1960_c20160223.csv","StormEvents_fatalities-ftp_v1.0_d1961_c20160223.csv","StormEvents_fatalities-ftp_v1.0_d1962_c20160223.csv", "StormEvents_fatalities-ftp_v1.0_d1963_c20160223.csv", "StormEvents_fatalities-ftp_v1.0_d1964_c20160223.csv", "StormEvents_fatalities-ftp_v1.0_d1965_c20160223.csv", 
"StormEvents_fatalities-ftp_v1.0_d1966_c20160223.csv", "StormEvents_fatalities-ftp_v1.0_d1967_c20160223.csv", "StormEvents_fatalities-ftp_v1.0_d1968_c20160223.csv", 
"StormEvents_fatalities-ftp_v1.0_d1969_c20160223.csv")

urlDescarga<-"http://www1.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/"
if( exists("fatalities") ){
	rm(fatalities)
}


for( archivo in archivosDescarga ){
  archivoDisco<-paste(dirDatos, archivo, sep="/")  
  if( ! file.exists(archivoDisco)) { 
  	archivoComp<-paste(dirDescarga, archivo, sep="")
    archivoComp<-paste(archivoComp, "gz", sep=".")       
    destArchivo<-paste(dirDescarga, archivo, sep="/")
    destArchivo<-paste(destArchivo, "gz", sep=".")
    if( ! file.exists(archivoComp) ){
    	archivoDescarga<-paste(urlDescarga, archivo, sep="")
    	archivoDescarga<-paste(archivoDescarga, "gz", sep=".")
        download.file(archivoDescarga, destArchivo)        
    }
    gunzip(destArchivo, archivoDisco) 
  }
  if( !exists("fatalities" ) ) {
	fatalities<-read.csv( archivoDisco, header=T, sep=",", na.strings="")
  } else {
	data<-read.csv(archivoDisco, header=T, sep=",", na.strings="")
	fatalities<-rbind(fatalities,data)
	rm(data)
  }  
}

nrow(fatalities)

