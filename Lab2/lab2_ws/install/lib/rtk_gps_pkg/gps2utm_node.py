import utm
import rospy
from sensor_msgs.msg import NavSatFix
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Point
#a = utm.from_latlon(latd, longd)  # Get UTM Data from Lat-Lon
def callback(data):
     print "Data Set:"
     rospy.loginfo(rospy.get_caller_id() + " Subscribed to Latitude:   %s", data.latitude)
     rospy.loginfo(rospy.get_caller_id() + " Subscribed to Longtitude: %s", data.longitude)
     rospy.loginfo(rospy.get_caller_id() + " Subscribed to Altitude:   %s", data.altitude)
     a= utm.from_latlon(data.latitude,data.longitude)
     publisher(a,data.altitude)

def listener():
    rospy.init_node('gps2utm_node', anonymous=True)
    rospy.Subscriber("/rtk_fix", NavSatFix, callback)
    rospy.spin()

def publisher(a,alt):
    print a
    lat=float (a[0])
    long=float (a[1])

    gps2=Odometry()
    pub = rospy.Publisher("/utm_fix", Odometry, queue_size=10)  # sensor_msgs/NavSatFix
    rospy.init_node('gps2utm_node', anonymous=True)
    gps2.pose.pose.position = Point(lat,long,alt)
    pub.publish(gps2)
    print "Publishing..."

if __name__ == '__main__':
    listener()