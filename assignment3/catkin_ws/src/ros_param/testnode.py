#Test node which will read parameters and perform sample tasks
import rospy


def func(firstname,lastname)
    print ('My name is: ' + firstname + ' ' + lastname)

if __name__ == '__main__':
    rospy.init_node('testnode')
    firstname=rospy.get_param(firstname)
    lastname=rospy.get_param(lastname)
    func(firstname,lastname)
