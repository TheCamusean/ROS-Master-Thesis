
%% Frpm here on
close all;

figure(1);
hold on;

for i=1:3
   
    plot(F(:,1),F(:,i+1));
end
hold off;

%% Markers init

pertmod = Data_well;

figure(2);
hold on;

for i=1:6
    plot(pertmod(:,1),pertmod(:,size(pertmod,2)-6+i)-6+i);
    
end

hold off;




%% Check by Sight the tm and tf
%% 23.8s for markers & 56.93 for force sensor
tf=74.34;
tm=8.5;

figure(3);
hold on;

for i=2:4
   plot(F(:,1)-tf,F(:,i));
    
    
end

for i=1:1
  plot(pertmod(:,1)-tm,pertmod(:,size(pertmod,2)-6+i));
    
    
end

plot(pertmod(:,1)-tm,pertmod(:,11:13));
    
hold off;
%% The Data = Kinematics +Force Sensor information

% vTm(:,1) = pertmod(:,1)-tm;
% vTm(:,2) = ones(size(pertmod,1),1);
% 
% vTf(:,1) = F(:,1) - tf;
% vTf(:,2) = zeros(size(F,1),1);
% 
% vT= [vTm;vTf];
% 
% vTsort = sortrows(vT,1);
% 
% figure(4);
% plot(vTsort(:,1),vTsort(:,2),'*');
% 
% Data = zeros(1,size(F,2)+size(pertmod,2)-1);
% cf=1;
% cm=1;
% for i= 1:size(vTsort,1)
%        Data(i+1,1) = vTsort(i,1);
%    if vTsort(i,2) == 0
%        Data(i+1,2:size(pertmod,2)) = Data(i,2:size(pertmod,2));
%        Data(i+1,size(pertmod,2)+1:size(Data,2)) = F(cf,2:size(F,2));
%        cf = cf+1;
%        
%    else
%        Data(i+1,2:size(pertmod,2)) = pertmod(cm,2:size(pertmod,2));
%        Data(i+1,size(pertmod,2)+1:size(Data,2)) = Data(i,size(pertmod,2)+1:size(Data,2));
%        cm = cm+1;
%        
%    end
%     
%     
% end


%% fill the holes


vTm(:,1) = pertmod(:,1)-tm;
vTm(:,2:size(pertmod,2)) = pertmod(:,2:end);
vTm(:,size(pertmod,2)+1:size(pertmod,2)+size(F,2)-1) = zeros(size(pertmod,1),size(F,2)-1);
vTm(:,size(pertmod,2)+size(F,2))=ones(size(pertmod,1),1);

vTf(:,1) = F(:,1) - tf;
vTf(:,2:size(pertmod,2)) = zeros(size(F,1),size(pertmod,2)-1);
vTf(:,size(pertmod,2)+1:size(pertmod,2)+size(F,2)-1) = F(:,2:end);
vTf(:,size(pertmod,2)+size(F,2)) = zeros(size(F,1),1);

vT= [vTm;vTf];



vTsort = sortrows(vT,1);

figure(4);
plot(vTsort(:,1),vTsort(:,end),'*');

V1 = find(vTsort(:,end)==1);
V1(1:end-1,2) = V1(2:end,1) - V1(1:end-1,1);

x = find(V1(:,2)>1);
V1_lim = V1(x,:);

for i= 1:size(V1_lim,1)
    
   vTsort(V1_lim(i,1):V1_lim(i,1)+V1_lim(i,2)-1,2:size(pertmod,2)) = ones(V1_lim(i,2),1)*vTsort(V1_lim(i,1),2:size(pertmod,2));
    
end

V2 = find(vTsort(:,end)==0);
V2(1:end-1,2) = V2(2:end,1) - V2(1:end-1,1);

x = find(V2(:,2)>1);
V2_lim = V2(x,:);

l1 = size(pertmod,2);
l2 = size(F,2);
for i= 1:size(V2_lim,1)
    
   vTsort(V2_lim(i,1):V2_lim(i,1)+V2_lim(i,2)-1,l1+1:l1+l2-1) = ones(V2_lim(i,2),1)*vTsort(V2_lim(i,1),l1+1:l1+l2-1);
    
end


t0 = find(vTsort(:,1)>0);

Data = vTsort(t0:end,1:end-1);

