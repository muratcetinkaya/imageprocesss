
clc; clear;
close all; objects = imaqfind %find video input objects in memory
delete(objects) %delete a video input object from memory
 pause(3)
a=arduino('COM3', 'Uno', 'Libraries', 'Servo');
   configurePin(a, 'D2', 'pullup');
start_button = readDigitalPin(a, 'D2');
servo1 = servo(a, 'D3'); %base
servo2 = servo(a, 'D5'); %arkasag
servo3 = servo(a, 'D9'); %kiskac
servo4 = servo(a, 'D10'); %arkasol
    writePosition(servo1, 0.52);
    writePosition(servo2, 0);
    writePosition(servo3, 0);
    writePosition(servo4, 0.33);
 kirmizi=0.24;
yesil=0.05;
mavi=0.15;
vidy = videoinput('winvideo', 1, 'YUY2_640x480');
set(vidy, 'FramesPerTrigger', Inf);
set(vidy, 'ReturnedColorspace', 'rgb')
vidy.FrameGrabInterval = 3;
start(vidy)


while(vidy.FramesAcquired<=20000)

    data = getsnapshot(vidy);

    diff_kirmizi = imsubtract(data(:,:,1), rgb2gray(data));
    diff_kirmizi = medfilt2(diff_kirmizi, [3 3]);
    diff_kirmizi= im2bw(diff_kirmizi,kirmizi);
    diff_kirmizi = bwareaopen(diff_kirmizi,300);
    bw = bwlabel(diff_kirmizi, 8);
    stats_kirmizi = regionprops(bw, 'BoundingBox', 'Centroid','Area');
    diff_mavi = imsubtract(data(:,:,3), rgb2gray(data));
    diff_mavi = medfilt2(diff_mavi, [3 3]);
    diff_mavi= im2bw(diff_mavi,mavi);
    diff_mavi = bwareaopen(diff_mavi,300);
    bm = bwlabel(diff_mavi, 8);
    stats_mavi = regionprops(bm, 'BoundingBox', 'Centroid','Area')
    diff_yesil = imsubtract(data(:,:,2), rgb2gray(data));
    diff_yesil = medfilt2(diff_yesil, [3 3]);
    diff_yesil= im2bw(diff_yesil,yesil);
    diff_yesil = bwareaopen(diff_yesil,300);
    by = bwlabel(diff_yesil, 8);
    stats_yesil = regionprops(by, 'BoundingBox', 'Centroid','Area');
hold on

a=getsnapshot(vidy);

imagegray=rgb2gray(a);
level=graythresh(imagegray)
bw=im2bw(imagegray,0.48);
bw=bwareaopen(bw,30); %% 30 px den az nesneler kaldırılıyor
se=strel('disk',10); 
bw=imclose(bw,se);
bw=imfill(~bw,'holes');

[B,L] = bwboundaries(bw,'noholes'), disp(B)
figure(2), imshow(label2rgb(L, @jet, [.5 .5 .5]))
 hold on


 for k= 1:length(B)
     boundary = B{k};
     
     plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
 end
 fprintf('nesneler işaretlendi toplam nesne sayısı:',k)
 stats= regionprops(L, 'Area', 'Centroid');

 for k=1:length(B)
     boundary=B{k}; 
     delta_sq=diff(boundary).^2;
     perimeter=sum(sqrt(sum(delta_sq,2)));
     area=stats(k) .Area;
     metric= 4*pi*area/perimeter^2;
     metric_string=sprintf('%2.2f',metric);
     centroid=stats(k).Centroid;

for object = 1:length(stats_kirmizi)
        bws = stats_kirmizi(object).BoundingBox;
        xk = stats_kirmizi(object).Centroid;
        ak = stats_kirmizi(object).Area;
 rectangle('Position',bws,'EdgeColor','r','LineWidth',2)
       plot(xk(1),xk(2), '-m+')  






if(ak>15) && (metric>=0.76) && (metric<=0.86)

text(centroid(1),centroid(2),'Kırmızı Dikdörtgen');

for baseaci = 0.52:0.01:0.55
           writePosition(servo1, baseaci);
pause(0.01);
    end
    
 for solaci = 0.33:-0.05:0.09
           writePosition(servo4, solaci);
pause(0.01);
 end

    for kiskacaci = 0:0.01:0.25
           writePosition(servo3, kiskacaci);
pause(0.01);
    end

    for sagaci = 0:0.01:0.37
           writePosition(servo2, sagaci);
pause(0.01);
    end

           writePosition(servo3, 0.08);


for sagaci = 0.37:-0.01:0
           writePosition(servo2, sagaci);
pause(0.01);
end

%%%%%%%%%%%%%%% kırmızı dikdörtgen dönüş

for baseaci = 0.52:0.01:0.83
           writePosition(servo1, baseaci);
pause(0.01);
    end

for solaci = 0.09:-0.01:0.00
           writePosition(servo4, solaci);
pause(0.01);
 end
  for sagaci = 0:0.01:0.38
           writePosition(servo2, sagaci);
pause(0.01);
  end

for kiskacaci = 0.08:0.01:0.15
           writePosition(servo3, kiskacaci);
pause(0.01);
    end


for sagaci = 0.38:-0.01:0
           writePosition(servo2, sagaci);
pause(0.01);
end
for kiskacaci = 0.15:-0.01:0.0
           writePosition(servo3, kiskacaci);
pause(0.01);
end
for solaci = 0:0.01:0.33
           writePosition(servo4, solaci);
pause(0.01);
 end
for baseaci = 0.83:-0.01:0.52
           writePosition(servo1, baseaci);
pause(0.01);
    end


pause(13);

end

if(ak>15) && (metric>=0.62) && (metric<=0.68)

text(centroid(1),centroid(2),'Kırmızı Üçgen');
for baseaci = 0.52:0.01:0.55
           writePosition(servo1, baseaci);
pause(0.01);
    end
    
 for solaci = 0.33:-0.05:0.09
           writePosition(servo4, solaci);
pause(0.01);
 end

    for kiskacaci = 0:0.01:0.25
           writePosition(servo3, kiskacaci);
pause(0.01);
    end

    for sagaci = 0:0.01:0.37
           writePosition(servo2, sagaci);
pause(0.01);
    end

           writePosition(servo3, 0.03);


for sagaci = 0.37:-0.01:0
           writePosition(servo2, sagaci);
pause(0.01);
end

%%%%%%%%%%%%%%% kırmızı üçgen dönüş

for baseaci = 0.52:0.01:0.72
           writePosition(servo1, baseaci);
pause(0.01);
    end


 
  for sagaci = 0:0.01:0.49
           writePosition(servo2, sagaci);
pause(0.01);
  end

for kiskacaci = 0.08:0.01:0.15
           writePosition(servo3, kiskacaci);
pause(0.01);
end

for sagaci = 0.49:-0.01:0
           writePosition(servo2, sagaci);
pause(0.01);
end
for kiskacaci = 0.15:-0.01:0.0
           writePosition(servo3, kiskacaci);
pause(0.01);
end
for solaci2 = 0.09:0.009:0.33
           writePosition(servo4, solaci2);
pause(0.01);
 end
for baseaci = 0.72:-0.01:0.52
           writePosition(servo1, baseaci);
pause(0.01);
    end

pause(13);
end

end
for object = 1:length(stats_mavi)
        bm = stats_mavi(object).BoundingBox;
        xm = stats_mavi(object).Centroid;
        am = stats_mavi(object).Area;
rectangle('Position',bm,'EdgeColor','b','LineWidth',2)
       plot(xm(1),xm(2), '-m+')



if(am>15) && (metric>=0.76) && (metric<=0.84) %mavi dikdörtgen lokasyonu

text(centroid(1),centroid(2),'Mavi Dikdörtgen');
for baseaci = 0.52:0.01:0.55
           writePosition(servo1, baseaci);
pause(0.01);
    end
    
 for solaci = 0.33:-0.05:0.09
           writePosition(servo4, solaci);
pause(0.01);
 end

    for kiskacaci = 0:0.01:0.25
           writePosition(servo3, kiskacaci);
pause(0.01);
    end

    for sagaci = 0:0.01:0.37
           writePosition(servo2, sagaci);
pause(0.01);
    end

           writePosition(servo3, 0.08);


for sagaci = 0.37:-0.01:0
           writePosition(servo2, sagaci);
pause(0.01);
end

%%%%%%%%%%%%%%% mavi dikdörtgen dönüş

for baseaci = 0.52:-0.01:0.30
           writePosition(servo1, baseaci);
pause(0.01);
    end

for solaci = 0.09:-0.01:0.00
           writePosition(servo4, solaci);
pause(0.01);
 end
  for sagaci = 0:0.01:0.31
           writePosition(servo2, sagaci);
pause(0.01);
  end

for kiskacaci = 0.08:0.01:0.15
           writePosition(servo3, kiskacaci);
pause(0.01);
    end


for sagaci = 0.31:-0.01:0
           writePosition(servo2, sagaci);
pause(0.01);
end
for kiskacaci = 0.15:-0.01:0.0
           writePosition(servo3, kiskacaci);
pause(0.01);
end
for solaci = 0:0.01:0.33
           writePosition(servo4, solaci);
pause(0.01);
 end
for baseaci = 0.30:0.01:0.52
           writePosition(servo1, baseaci);
pause(0.01);
end
pause(13);

end






if(am>15) && (metric>=0.64) && (metric<=0.72) %mavi üçgen lokasyonu
    
text(centroid(1),centroid(2),'Mavi Üçgen');
for baseaci = 0.52:0.01:0.54
           writePosition(servo1, baseaci);
pause(0.01);
    end
    
 for solaci = 0.33:-0.05:0.11
           writePosition(servo4, solaci);
pause(0.01);
 end

    for kiskacaci = 0:0.01:0.20
           writePosition(servo3, kiskacaci);
pause(0.01);
    end

    for sagaci = 0:0.01:0.45
           writePosition(servo2, sagaci);
pause(0.01);
    end

           writePosition(servo3, 0.05);

for sagaci = 0.45:-0.01:0
           writePosition(servo2, sagaci);
pause(0.01);
end

for baseaci = 0.52:-0.01:0.37
           writePosition(servo1, baseaci);
pause(0.01);
    end
 for sagaci = 0:0.01:0.49
           writePosition(servo2, sagaci);
pause(0.01);
 end
 for kiskacaci = 0.05:0.01:0.15
           writePosition(servo3, kiskacaci);
pause(0.01);
 end

 for sagaci = 0.49:-0.01:0
           writePosition(servo2, sagaci);
pause(0.01);
end



 for kiskacaci = 0.15:-0.01:0.0
           writePosition(servo3, kiskacaci);
pause(0.01);
 end
 for solaci = 0.11:0.01:0.33
           writePosition(servo4, solaci);
pause(0.01);
 end
for baseaci = 0.37:0.01:0.52
           writePosition(servo1, baseaci);
pause(0.01);
    end

pause(13);


end

end

hold off




 end
 disp(metric)
text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y','Fontsize',14,'FontWeight','bold');
end

stop(vidy);
flushdata(vidy);
imaqreset;
clc;
clear all;
