#!/usr/bin/env Rscript
## VERA: Verreaux's Eagle Risk Analysis
# Megan Murgatroyd



library(methods)
require(effects)
riskmod <- readRDS("riskmod.rds")

#this allows you to see the effects of each vairable, it's not important at the stage as this is not the final model 
#but it does include all of the relevant variables that I expect will feature in the final model.
#plot(allEffects(riskmod), type="response")

##### WEBSITE SIMULATION: CAPE POINT#####
require(rgdal)
require(raster)


#Scenario: A developer is interested in putting a wind farm on the Cape Penninsula, there is one Verreaux's eagle nest on site:
#This is the development area as a shapefile:
#NB: you should be able to enter any shapfile/coordinates here and that links to the next step to souce the DEMs, consider inventing a development in the Karoo... as I have invented this one

arguments = commandArgs(trailingOnly = TRUE)
args1 <- strsplit(arguments,",")
print(args1)

shapefile <- "penninsula"
srtm30a<-raster("s34_e018_1arc_v3.tif")
srtm30b<-raster("s35_e018_1arc_v3.tif")
#shapefile <- as.character(args1[1])
#srtm30a <- raster(as.character(args1[2]))
#srtm30b <- raster(as.character(args1[3]))


#merge the two together:
dem=merge(srtm30a, srtm30b)
rm(srtm30a, srtm30b)


dev=readOGR(".",shapefile)
lin <- as(dev, "SpatialLinesDataFrame")
allcoordinates <- spbabel::sptable(dev)

#plot(dem)
#plot(dev, add=T)
#Extract the info needed for the model:
slope<-terrain(dem, opt=c('slope'), unit='degrees', neighbors=8)
aspect<-terrain(dem, opt=c('aspect'), unit='degrees')
slope_sd3=focal(slope, w=matrix(1,3,3), fun=sd) ##NB this layer take 5min+ to make. It is taking each grid cell and finding the standard deviation of the altitude of it and the cells around it on a 3x3 grid (i.e. SD of 9 cells)
#make a terrain.stack of these layers:

terrain.stack_pen<-stack(list(slope=slope,  aspect=aspect, slope_sd3=slope_sd3, alt=dem)) 

#Crop the terrain.stack by the development boundaries:
crs(dev)=crs(dem)
dem_dev <- crop(terrain.stack_pen, extent(dev), snap='out')
rar <- mask(dem_dev, dev)

#convert the raster to points, and convert these points to a dataframe:
rarToP <- rasterToPoints(rar, byid=TRUE, id=rar$nests)
rm(rar)
dev.terrain <- as.data.frame(rarToP)

#change x y column names:
names(dev.terrain)[names(dev.terrain) == "x"] <- "longitude"
names(dev.terrain)[names(dev.terrain) == "y"] <- "latitude"


#add distance to nes: dist_nest:
#The developer needs to provide the nest coordinates, here I input them:
#consider choosing a random area in the Karoo, select any cliff and simulate a Verreaux's eagle nest there and one more 3-5 km away on another cliff
dev.terrain$nest_lat= -34.071917
dev.terrain$nest_long= 18.379949


#calculate the distance between the nest and each grid cell (now each row in the dataframe):
require(geosphere)

df=data.frame(long=dev.terrain$longitude, lat=dev.terrain$latitude)
df2=data.frame(long=dev.terrain$nest_long, lat=dev.terrain$nest_lat)

d=distGeo(df, df2)
d=as.data.frame(d)

#convert to km and add to dataframe:
dev.terrain$nest_dist=d$d/1000


#add categorical aspect to dataframe:
dev.terrain$asp4<-
  ifelse((dev.terrain$aspect <= 45 | dev.terrain$aspect >= 315), "N",
         ifelse((dev.terrain$aspect >= 45 & dev.terrain$aspect < 125), "E",
                ifelse((dev.terrain$aspect >= 125 & dev.terrain$aspect < 225), "S",
                       ifelse((dev.terrain$aspect >= 225 & dev.terrain$aspect < 315), "W", "NA"))))
dev.terrain$asp4=as.factor(dev.terrain$asp4)


####Data frame in now ready to run the model over:
pred<-predict(riskmod, dev.terrain, re.form = NA, type = "response", na.action = na.fail)

pred=as.data.frame(pred)

#you now have probablities 0 -1 which need plotting / converting to tiff / raster:
#summary(pred$pred)

#RISK PLOT:
toplot=cbind.data.frame(long= dev.terrain$longitude, lat=dev.terrain$latitude, pred=pred$pred)

potplot <- subset.data.frame(toplot, toplot$pred >0.2)
potlist <- write.csv(potplot, "output.csv", row.names = F, col.names = F)
risk_plot=rasterFromXYZ(toplot)



colours=c("darkseagreen1","darkorange","red")
#plot(risk_plot, col=colours)
#plot(dev, add=T)
#writeRaster(risk_plot, "capepoint_risk", format = "GTiff")

