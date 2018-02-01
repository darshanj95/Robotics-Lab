#This file will process the data of GPS from minicom

import sys
import lcm
import time
import serial
import utm
from exlcm import gpst_t
import utm


class gps(object):
    def __init__(self):
        self.port=serial.Serial('/dev/ttyUSB1', 4800, timeout=1.)  # 4800-N-8-1
        self.lcm=lcm.LCM()
        self.packet=gpst_t() 
	print("GPS Initialisation Successful")

    def readloop(self):
        while True:
	    try:
                line = self.port.readline()
		vals=line.split(",")			#Line Split ","
		self.packet.time=float(vals[1]) 	# Converting String to Float
                self.packet.latitude=float(vals[2])
		self.packet.longitude=float(vals[4])
		self.packet.altitude=float(vals[9])
		if vals[0]=='$GPGGA':             	#Checking for Message ID     		 
		     latitude=float(vals[2])    		 
		     if vals[3] == 'S':
		         latitude=-latitude
		     else: 
			 latitude=latitude
		     latd=latitude//100			#Convert Latitude Data
		     latm=latitude-(latd*100)
		     latd= latd + latm/60		 
		     print latd
	 	     longitude=float(vals[4])
	             if vals[5] == 'W':
		         longitude=-longitude
		     else:
			 longitude=longitude 
		     longd=longitude//100		#Convert Longitude Data
		     longm=longitude-longd*100
		     longd= longd + longm/60
		     print longd		     
		     a= utm.from_latlon(latd,longd)     #Get UTM Data from Lat-Lon	 	     
		     print a
		     print float(a[0])		
		     self.packet.utm_x=float(a[0])
		     self.packet.utm_y=float(a[1])		             
                     self.lcm.publish("GPS", self.packet.encode()) #Publish Data
		     print "Data Publishing.."		   		
            except:
                print ("Error" + line) 			#If Message ID != $GPGGA
        
if __name__ == "__main__":
    
    gps1 = gps()
    gps1.readloop()
		
		 
