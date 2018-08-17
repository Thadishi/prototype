import pyRserve

conn = pyRserve.connect()

conn.eval('library(effects)')
conn.eval('library(raster)')