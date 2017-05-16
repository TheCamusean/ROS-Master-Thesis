%% Obtain interesting Features from Data
close all;
Data;


%% Take the relevant data from 

tinit = 20;
tend = 180;

ninit = min(find(Data(:,1)>tinit));
nend =  max(find(Data(:,1)<tend));

%Data = Data(ninit:nend,:);


%% Force info  in anterior direction : 


figure(1);
hold on;
for i=0:1
   
    plot(Data(:,end-3*i))
    
end

FLz = Data(:,end);
FFz = Data(:,end-3);

%% End Effector pos  14,15,16: 

iee=11;

pEE = Data(:,iee:iee+2);

figure(2);
subplot(3,1,1)
plot(Data(:,1),pEE)

pEE_offs(:,1) = pEE(:,1) - pEE(1,1);
pEE_offs(:,2) = pEE(:,2) - pEE(1,2);
pEE_offs(:,3) = pEE(:,3) - pEE(1,3);


subplot(3,1,1)
plot(Data(:,1),pEE_offs)
legend('x','y','z');


%% End Effector's velocity && acceleration

tStep = Data(end,1)/size(Data,1);

%0.2 seconds are equivalent to : 

nStep = floor(0.2/tStep);

%velocity

vEE = zeros(size(pEE,1),size(pEE,2));

vEE(nStep+1:end,1) = (pEE(nStep+1:end,1)-pEE(1:end-nStep,1))/0.2;
vEE(nStep+1:end,2) = (pEE(nStep+1:end,2)-pEE(1:end-nStep,2))/0.2;
vEE(nStep+1:end,3) = (pEE(nStep+1:end,3)-pEE(1:end-nStep,3))/0.2;

%Eliminate values over a threshold

vEE(vEE>1) = 0;
vEE(vEE<-1) = 0;

subplot(3,1,2)
plot(Data(:,1),vEE);
legend('vx','vy','vz')

% acceleration

aEE = zeros(size(pEE,1),size(pEE,2));

aEE(nStep+1:end,1) = (vEE(nStep+1:end,1)-vEE(1:end-nStep,1))/0.2;
aEE(nStep+1:end,2) = (vEE(nStep+1:end,2)-vEE(1:end-nStep,2))/0.2;
aEE(nStep+1:end,3) = (vEE(nStep+1:end,3)-vEE(1:end-nStep,3))/0.2;

subplot(3,1,3)
plot(Data(:,1),aEE);
legend('ax','ay','az')% Y muevo,

ZpvaF(:,1)=Data(:,1);
ZpvaF(:,2)=pEE(:,2);
ZpvaF(:,3)=vEE(:,2);
ZpvaF(:,4)=aEE(:,2);

% F -> 26 anterior 27 height 28 out movement
ZpvaF(:,5)=Data(:,28);

% CoM 

ZpvaF(:,6) = Data(:,9);
vCoM = zeros(size(pEE,1),1);

vCoM(nStep+1:end) = (Data(nStep+1:end,9)-Data(1:end-nStep,9))/0.2;
ZpvaF(:,7) = vCoM;


figure(0101);

plot(ZpvaF(:,1),pEE(:,2));
hold on;
plot(ZpvaF(:,1),ZpvaF(:,5));
plot(ZpvaF(:,1),ZpvaF(:,7));




%% Check when walking stars.

% Walking in Z direction

Steps(:,1) = Data(:,1);
Steps(:,2) = Data(:,4)-Data(1,4);
Steps(:,3) = Data(:,7)-Data(1,7);

%Detect walking initialitation

figure(11);
plot(Steps(:,1),Steps(:,2:end))

S = [find(Steps(:,2)>0.006); find(Steps(:,3)>0.006)];

S = sort(S);
S(:,2)=Steps(S,1);
S(1,3) = 10;
S(2:end,3) = S(2:end,2) - S(1:end-1,2);

figure(12)
plot(S(:,2),S(:,3),'o');
hold on;
plot(Steps(:,1),100*Steps(:,2));
plot(Steps(:,1),100*Steps(:,3));

% Select those over a threshold of 2 seconds

first_step = find(S(:,3)>2);
fs = S(first_step,1:2);

figure(13)

plot(fs(:,2),zeros(size(fs,1),1),'*');

%% Take the the previous 3.4 data from the Step info : 

% Follower moves backwards :


fb = fs(1:2:end,:);
nt0= min(find(Data(:,1)>fb(1,2)-3.4));
alpha = fb(1,1)-nt0;


for i=1:size(fb,1)
   
    Feat_Data(:,:,i) = Data(fb(i,1)-alpha:fb(i,1),:);
    
end

