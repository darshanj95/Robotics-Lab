%Image1
I=imread('cinder1.jpg');
[J,newOrigin] = undistortImage(I,cameraParams);
figure; imshowpair(I,J,'montage');
title('Original Image (left) vs. Corrected Image (right)');
imwrite(J,'Ucinder1.jpg')

%Image2
I2=imread('cinder2.jpg');
[J2,newOrigin2] = undistortImage(I2,cameraParams);
figure; imshowpair(I2,J2,'montage');
title('Original Image (left) vs. Corrected Image (right)');
imwrite(J,'Ucinder2.jpg')

%Image3
I3=imread('cinder3.jpg');
[J3,newOrigin3] = undistortImage(I3,cameraParams);
figure; imshowpair(I3,J3,'montage');
title('Original Image (left) vs. Corrected Image (right)');
imwrite(J3,'Ucinder3.jpg')

%Image4
I4=imread('cinder4.jpg');
[J4,newOrigin4] = undistortImage(I4,cameraParams);
figure; imshowpair(I4,J4,'montage');
title('Original Image (left) vs. Corrected Image (right)');
imwrite(J4,'Ucinder4.jpg')

%Image5
I5=imread('cinder5.jpg');
[J5,newOrigin5] = undistortImage(I5,cameraParams);
figure; imshowpair(I5,J5,'montage');
title('Original Image (left) vs. Corrected Image (right)');
imwrite(J5,'Ucinder5.jpg')

%Image6
I6=imread('cinder6.jpg');
[J6,newOrigin6] = undistortImage(I6,cameraParams);
figure; imshowpair(I6,J6,'montage');
title('Original Image (left) vs. Corrected Image (right)');
imwrite(J6,'Ucinder6.jpg')

% %Image7
% I7=imread('artmural7.jpg');
% [J7,newOrigin7] = undistortImage(I7,cameraParams);
% figure; imshowpair(I7,J7,'montage');
% title('Original Image (left) vs. Corrected Image (right)');
% imwrite(J7,'Uartmural7.jpg')
