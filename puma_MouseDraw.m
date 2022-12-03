clear all;
mdl_puma560 %puma model 

filename1='IXT.txt'; %read trajectory
filename2='IZT.txt';
A=importdata(filename1,'%f');
B=importdata(filename2,'%f');
 graphics=[A B]; 
 graf = graphics;
 s=[];
 y=[];
 
 
for i=2:50:size(graf,1)  %多少个点采样一次
    Px = graf(i,1)/1200;
    Pz = graf(i,2)/1200;
    Py = -600/1200;
    tform = rpy2tr(136,-180,-180); %欧拉角转姿态齐次矩阵
    targetPos = [Px Py Pz]; %末端位置向量
    
    s=cat(1,s,targetPos);
    y=cat(1,y,[1 1 1 1]);
    %eeposition an N x 2 or N x 3 matrix
    %assignin('base','eePositions',[A';B';B']);  %put matrix into workspace as eePositions
    %assignin('base','wayPoints',[A';B';B';B']);  %put matrix into workspace as wayPoints
    
    TR=transl(targetPos)*tform; %位姿齐次矩阵
    hold on
    grid on
    plot3(Px,Py,Pz,'.r','LineWidth',1);
    q=p560.ikine6s(TR);
%     pause(0.01)
    p560.plot(q);%动画演示
end   
eePositions=s;
wayPoints=y;


