import rospy
from sensor_msgs.msg import NavSatFix
def scooby():
    gps1=NavSatFix()
    pub=rospy.Publisher("/rtk_new", NavSatFix, queue_size=10)
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10)
    for i in range (1,2000):
            gps1.latitude=42
            gps1.longitude=-71
            gps1.altitude=i
            pub.publish(gps1)
            print "Publishing data:"
            print i
            rate.sleep()



if __name__ == '__main__':
    try:
        scooby()
    except rospy.ROSInterruptException:
        pass

