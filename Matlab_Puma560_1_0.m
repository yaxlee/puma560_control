%% 1.0 matlab可以控制Simscape中的模型。但是是乱动
clear all; close all; clc;
%% load Puma560 model data file
run('RobotPUMA560_2_0_DataFile')


%%

import ETS3.*;

%% Home Configuration of Robot Model

q1_home = 0;
q2_home = -30;
q3_home = 120;
q4_home = 0;
q5_home = 20;

homeconfig = [q1_home, q2_home, q3_home, q4_home, q5_home];

%% Move Robot

close all;

q_0 = homeconfig; % Define the joint angles for the home pose
q_1 = [0, 0, 0, 0, 0]; % Define the joint angles for the first pose
q_2 = [-45, 30, 45, 90, 90, 45]; % Define the joint angles for the second pose
q_3 = [45, 30, 45, -90, 90, -45]; % Define the joint angles for the third pose
steps = 10; % Define the number of steps taken in the trajectory

q = mtraj(@lspb,q_0,q_1,steps); % Create the trajectory

% q = mtraj(@lspb,q_1,q_0,steps); % Create the trajectory

% q = mtraj(@lspb,q_0,q_2,steps); % Create the trajectory

% q = mtraj(@lspb,q_2,q_0,steps); % Create the trajectory 


% q = mtraj(@lspb,q_0,q_3,steps); % Create the trajectory

% q = mtraj(@lspb,q_3,q_0,steps); % Create the trajectory 


%% Extract Joint Trajectory Information

% [t01,t01d,t01dd] = jtraj(q_0, q_1, steps);
[t10,t10d,t10dd] = jtraj(q_1, q_0, steps);
% [t02,t02d,t02dd] = jtraj(q_0, q_3, steps);
% [t20,t20d,t20dd] = jtraj(q_0, q_3, steps);
% [t03,t03d,t03dd] = jtraj(q_0, q_3, steps);
% [t30,t30d,t30dd] = jtraj(q_0, q_3, steps);
% figure()
% plot(t03);
% legend('q0','q1','q2','q3','q4','q5','location','NorthWest')

trajStartTime = 0; % seconds
trajEndTime = 5; % seconds

t1 = [linspace(trajStartTime,trajEndTime,length(q(:,1)))',-deg2rad(t10(:,1))];
t2 = [linspace(trajStartTime,trajEndTime,length(q(:,1)))',-deg2rad(t10(:,2))];
t3 = [linspace(trajStartTime,trajEndTime,length(q(:,1)))',-deg2rad(t10(:,3))];
t4 = [linspace(trajStartTime,trajEndTime,length(q(:,1)))',-deg2rad(t10(:,4))];
t5 = [linspace(trajStartTime,trajEndTime,length(q(:,1)))', deg2rad(t10(:,5))];

%% Run on Simulink Model

open('RobotPUMA560_2_1')
sim('RobotPUMA560_2_1')