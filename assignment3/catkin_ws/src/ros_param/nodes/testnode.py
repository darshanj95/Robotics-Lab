#!/usr/bin/env python
#Test node which will read parameters and perform sample tasks
import rospy

def func(firstname,lastname,age,gpa):
    print ('\nMy name is: ' + firstname + ' ' + lastname)
    print ('Age: ' + str(age))
    print ('Gpa: ' + str(gpa) + '\n')

if __name__ == '__main__':
    rospy.init_node('testnode')
    firstname=rospy.get_param('testnode/firstname')
    lastname=rospy.get_param('testnode/lastname')
    age = rospy.get_param('testnode/age')
    gpa = rospy.get_param('testnode/GPA')
    func(firstname,lastname,age,gpa)
