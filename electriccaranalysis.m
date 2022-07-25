
%initialisation section; do not remove this section 
clear all; %clear all variables
clc %clear command window
close all % close all open figures

%% Put your name, surname and student ID below
name='Kamil'
surname='Surname'

 
%% Your script should start below:
%2.1Load data into MATLAB
myfile=readtable('insert_file_name_here') %Importing data from the file(excel)
%2.2Electric Vehicle Performance
%2.2.1Electric vehicle performance
time=myfile.Time; %Exctracting time from file
speed=myfile.Speed*1.609344 %Extracting speed from data table and converting from mph(miles per hour)to km/h (kilometers per hour)
gear=myfile.Gear; %Extracting speed from file and converting from mph) to km/h.
elevation=myfile.Elv*0.3048; %Extracting data of the elevation
stateofcharge=myfile.SOC/10000; %Extracting data from file for the state of charge
batteryvoltage=myfile.PackVolts; %Extracting data from file for the battery voltage
batterycurrent=myfile.PackAmps; %Extracting data from file for the battery current
%2.2.2Electric vehicle performance
figure(1) 
subplot(1,6,1) %Creating the subplot command, which divides the current figures into an m-by-n grid
plot(time,speed,'-b'); %Plotting time to speed 
xlabel('Time(s)') %Command for naming x axis
ylabel('Speed(km/h)')  %Command for naming y axis
title('Time vs Speed') %Setting a title for the plot
subplot(1,6,2) 
plot(time,gear,'-r'); %Plotting the Time to the gear
xlabel('Time(s)')
ylabel('Gear') 
title('Time vs Gear') 
subplot(1,6,3) 
plot(time, stateofcharge, '-k') %Plotting the time to State of charge
xlabel('Time(s)')
ylabel('Elevation(m)') 
title('Time vs Elevation') 
subplot(1,6,4) 
plot(time,stateofcharge,'-k') 
xlabel('Time(s)') 
ylabel('Stateofcharge%')
title('Time vs Stateofcharge')
subplot(1,6,5)
plot(time,batteryvoltage,'-g') %Plotting the time to battery voltage
xlabel('Time(s)')
ylabel('Batteryvoltage')
title('Time vs Batteryvoltage') 
subplot(1,6,6)
plot(time,batterycurrent,'-m') %Plotting time to the battery current
xlabel('Time(s)')
ylabel('Batterycurrent')
title('Time vs Batterycurrent') 
sgtitle('Time vs Speed, Elevation,Gear,State of charge, Battery voltage, Baterry current'); % Naming the used plots
%2.3Power consumption
%2.3.1Power consumption - extracting the data 2.3.2 assinging the extracted data to variable
motor=myfile.MotorPwr_100w_/10;
auxpwr=myfile.AuxPwr_100w_/10;
acpwr=myfile.A_CPwr_250w_*0.25;
%2.3.3 Calculting the power of battery
batterypower=(batteryvoltage.*batterycurrent)/1000;
%2.3.4 Power consumption -creating the plot
figure(2)
plot(time,motor,'-r')%Plotting time to motor
hold on
plot(time,auxpwr,'--b') %Plotting time to auxpwr 
plot(time,acpwr,':g') %Plotting time to acpwr
plot(time,batterypower,'.-y') %Plotting  time to battery power 
xlabel('Time(s)')
ylabel('Power(kW)')
title('Times vs Power')
grid on 
legend('Motor Power','Auxiliary Power','A/C Power','Baterry Power'); %Adding the legend
%2.4 Acceleration and driving styles
%2.4.1 Accelration the driving styles - calculating the acceleration
for i=1:length(time)-1%Calculating the acceleration using the for..end comand and knowing that, the average acceleration in time interval is expressed by the speed divded by time
    acceleration(i)= (speed(i+1)-speed(i))./(time(i+1)-time(i));
end
%2.4.2 Creating variable ds_mapping
ds_mapping=zeros(1,length(time)-1);
for i=1:length(time)-1
    if abs(acceleration(i)) >=0.7&& abs(acceleration(i)) <=2.8
        ds_mapping(i)=1;
    elseif abs(acceleration(i)) >=2.81&& abs(acceleration(i)) <=3.64
        ds_mapping(i)=2;
    elseif abs(acceleration(i)) >=3.65&& abs(acceleration(i)) <=6.5
        ds_mapping(i)=3;
    else
        ds_mapping(i)=0;
    end
end
%2.4.3 Creating the plot of the calculated acceleration
figure(3)
plot(time(1:length(time)-1),acceleration,'-r') %Plotting the  length to acceleration
hold on
plot(time(1:length(time)-1),ds_mapping,'-b') %Plotting the length with ther results of ds_mapping
xlabel('Time(s)')
ylabel('Accerlation, m/s^2')
legend('Acceleration','Driving style');
%2.5 Battery pack temprature
%2.5.1 Battery pack temperature - extracting the temprature from thedataset
packT1=myfile.PackT1C; %Extracting data of the temprature from packT1C
packT2=myfile.PackT2C; %Extracting data of the temprature from packT2C
packT3=myfile.PackT3C; %Extracting data of the temprature from packT3C
packT4=myfile.PackT4C; %Extracting data of the temprature from packT4C
%2.5.2 Calculations
minpackT1=min(packT1); %Calculating the minimum of the temperature 1
maxpackT1=max(packT1); %Calculating the maximum of the temperature 1
averagepackT1=mean(packT1);%Calculating the average of the temperatre 1
minpackT2=min(packT2); %Calculatinge the minimum of the temprature 2
maxpackT2=max(packT2); %Calculating  the maximum of the temperature 2
averagepackT2=mean(packT2);%Calculating the average of the temprature 2
minpackT3=min(packT3);%Calculating minimum of the temperature 3
maxpackT3=max(packT3);%Calculating the average of the temprature 3
averagepackT3=mean(packT3);%Calculatingthe average of the temprature 3
minpackT4=min(packT4); %Calculating the minimum of the temperature 4
maxpackT4=max(packT4); %Calculating the maximum of the temperature 4
averagepackT4=mean(packT4); %Calculatinge the average of the temperature 4
% 2.5.3 Creation of the plot for all temperatures 
figure(4)
bar([maxpackT1 minpackT1 averagepackT1; maxpackT2 minpackT2 averagepackT2; maxpackT3 minpackT3 averagepackT3; maxpackT4 minpackT4 averagepackT4]);
xlabel('pack')
ylabel('Temprature(C)')
legend('MIN','MAX','AVERAGE');
title('Pack temperature MIN,MAX,AVERAGE')
grid on 
set(gca,'xticklabel',{'T1','T2','T3','T4'}); %Creating the name of the each bar under the pack tempratures, for examples T1,T2,..
