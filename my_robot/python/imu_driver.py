import lcm
import serial
from exlcm import imu_t

class imu(object):
    def __init__(self):
        self.port=serial.Serial('/dev/ttyUSB0','115200',timeout=1.)
        self.lcm=lcm.LCM()
        self.packet=imu_t( )
        print "IMU Initialized"

    def readloop(self):
        while True:
            line = self.port.readline()
            try:
                vals = line.split(',')
                self.packet.yaw=   float(vals[1])
                self.packet.pitch= float(vals[2])
                self.packet.roll=  float(vals[3])
                self.packet.MagX=  float(vals[4])
                self.packet.MagY=  float(vals[5])
                self.packet.MagZ=  float(vals[6])
                self.packet.AccelX=float(vals[7])
                self.packet.AccelY=float(vals[8])
                self.packet.AccelZ=float(vals[9])
                self.packet.GyroX=float(vals[10])
                self.packet.GyroY=float(vals[11])
                self.packet.GyroZ=1
                self.lcm.publish("IMU",self.packet.encode())
                print "Publishing IMU Data..."
            except:
                print "ERROR"

if __name__ == "__main__":
    imu1=imu()
    imu1.readloop()