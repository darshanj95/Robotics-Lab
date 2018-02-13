# This file will process the data of GPS from RTK and publish to topic
import socket
import rospy
from sensor_msgs.msg import NavSatFix
def readloop():
        print "Hello"
        s=socket.socket()
        host=rospy.get_param('~host' , '172.20.10.3')
        port=rospy.get_param('~port',3000)
        s.connect((host,port))
        GPS=s.recv(1024)
        gps1=NavSatFix()
        print("GPS Initialisation Successful")
        pub = rospy.Publisher("/rtk_fix", NavSatFix, queue_size=10)  # sensor_msgs/NavSatFix
        rospy.init_node('rtk_gps_node', anonymous=True)
        while True:
            try:
                print "1"
                print GPS
                mystring=GPS              	    #The data of GPS is assigned to a string
                keyword='$GPGGA,'
                befor_keyowrd, keyword, after_keyword = mystring.partition(keyword)
                print after_keyword         	#With this technique, All the data after '$GPGGA' is assigned to after_keyword
                vals= after_keyword.split(',')  #And now data assigned is split using ','
                latitude=float(vals[1])
                latd = latitude// 100           # Convert Latitude Data
                latm = latitude-(latd * 100)
                latd = latd+latm/60
                if vals[2] == 'S':
                    latd = -latd
                else:
                    latd = latd
                print latd
                longitude = float(vals[3])
                longd = longitude//100         # Convert Longitude Data
                longm = longitude-(longd*100)
                longd = longd+longm/60
                if vals[4] == 'W':
                    longd = -longd
                else:
                    longd = longd
                print longd
                gps1.latitude = latd
                gps1.longitude = longd
                gps1.altitude = float(vals[8])
                print gps1.latitude
                print gps1.longitude
                print gps1.altitude
                rospy.loginfo(gps1)
                pub.publish(gps1)
                print "Data Publishing.."
            except:
                print ("Error")

if __name__ == '__main__':
      try:
           readloop()
      except rospy.ROSInterruptException:
          pass

