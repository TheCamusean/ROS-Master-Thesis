%% From Feat_Data to Real_Feat

% Feat_DATA : {'Time',1;'FLegRight',2;'FLegLeft',
%5;'FCoM',8;'Fee',11;'FShLeft',14;'Fee2',17;
%'G1',20;'G2',23,'FFollower',26,'FLead',29};

%Feat_Data = F_Data;
% pEE relative to pSh

figure(1);
subplot(2,1,1)
plot(Data(:,1),Data(:,12));
hold on;
plot(Data(:,1),Data(:,15));
hold off;
subplot(2,1,2)
plot(Data(:,1),Data(:,12)-Data(:,15)-(Data(1,12)-Data(1,15)))

for i = 1:size(Feat_Data,3)

    PShEe(:,i) = Feat_Data(:,14,i)-Feat_Data(:,11,i) - (Feat_Data(1,14,i)-Feat_Data(1,11,i));

end

close all;
figure(1)

plot(Feat_Data(:,1),PShEe());


%pEE relative to relax pose

for i = 1:size(Feat_Data,3)

    PEeRel(:,i) = Feat_Data(:,11,i) -Feat_Data(1,11,i);

end

figure(2)

plot(Feat_Data(:,1),PEeRel());

% Force information in Z axis

for i = 1:size(Feat_Data,3)

    Fz(:,i) = Feat_Data(:,28,i) -Feat_Data(1,28,i);

end

figure(3)

plot(Feat_Data(:,1),Fz());

%


