import lcm
from exlcm import imu_t

def listener(channel,data):
    imu=imu_t.decode(data)
    print imu.yaw
lc = lcm.LCM()
subscription = lc.subscribe("IMU", listener)

try:
    while True:
        print "trying..."
        lc.handle()
except KeyboardInterrupt:
    pass

lc.unsubscribe(subscription)
