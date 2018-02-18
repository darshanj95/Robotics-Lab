   1 #!/usr/bin/env python
   2 
   3 import sys
   4 import rospy
   5 from beginner_tutorials.srv import *
   6 
   7 def add_two_ints_client(x, y):
   8     rospy.wait_for_service('add_two_ints')
   9     try:
  10         add_two_ints = rospy.ServiceProxy('add_two_ints', AddTwoInts)
  11         resp1 = add_two_ints(x, y)
  12         return resp1.sum
  13     except rospy.ServiceException, e:
  14         print "Service call failed: %s"%e
  15 
  16 def usage():
  17     return "%s [x y]"%sys.argv[0]
  18 
  19 if __name__ == "__main__":
  20     if len(sys.argv) == 3:
  21         x = int(sys.argv[1])
  22         y = int(sys.argv[2])
  23     else:
  24         print usage()
  25         sys.exit(1)
  26     print "Requesting %s+%s"%(x, y)
  27     print "%s + %s = %s"%(x, y, add_two_ints_client(x, y))
