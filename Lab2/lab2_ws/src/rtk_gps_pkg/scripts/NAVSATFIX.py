import rospy
from sensor_msgs.msg import NavSatFix
my=NavSatFix()
my.latitude=41
my.longitude=-70
my.altitude=2
print my.latitude

