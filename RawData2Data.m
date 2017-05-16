%% From Raw Data to a all markers in one


%rawdata;

% first row the names, second raw meeeh. thrid row XYZ

fid = fopen('fast_data.csv','r');
C = textscan(fid, repmat('%s',1,200), 'delimiter',',', 'CollectOutput',true);
C = C{1};
fclose(fid);


names = C(5:7,:);
rawdata = num2cell( str2double(C(8:end,:)));

%% Positionining

real_positions = {'Time',1;'FLegRight',2;...
    'FLegLeft',5;'FCoM',8;'Fee',11;...
    'FShLeft',14;'Fee2',17;'G1',20;'G2',23};


Data_well = zeros(size(rawdata,1),25);
%Data_well(:,1) = cell2mat(rawdata(:,1));
for i = 1:size(real_positions,1)
   
    IndexC = strfind(names(1,:), real_positions{i,1});
    Index = find(not(cellfun('isempty', IndexC)))
    real_positions(i,1)
    
    for j = 1:length(Index)
       
        
       Data_well(:,cell2mat(real_positions(i,2)):cell2mat(real_positions(i,2))+2) = Data_well(:,cell2mat(real_positions(i,2)):cell2mat(real_positions(i,2))+2) + cell2mat(rawdata(:,Index(j):Index(j)+2));
        
    end
    
end






