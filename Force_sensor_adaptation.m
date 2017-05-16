%% Force sensor adapatation 1

F(:,1) = Fall(:,1);
F(:,2:7) = Fall(:,8:13);



%% Force sensor adaptation 2
% 
% time = linspace(0,size(F1,1)*0.001,size(F1,1));
% 
% F(:,1) = time;
% F(:,2:4)=F1;
% F(:,5:7)=F2;
