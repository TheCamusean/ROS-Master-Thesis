F = Fall;
for i=1:size(F,1)-1
   
    x = strtok(F{i,4}(2:end),'-');
   
    F{i,4}= [F{i,4}(1) x];
    
    k = strfind(F{i,4},'.');
    
    if(size(k,2))==2
        F{i,4} =F{i,4}(1:k(2)-1);
    end
    
    if(length(F{i,4})>1)
        if(F{i,4}(1)=='0' && F{i,4}(2)~='.')

           F{i,4} = F{i,4}(1);
        end
    end
    F{i,4} = str2double(F{i,4});
end

F = cell2mat(F(1:end-1,:));
F(:,7) = zeros(size(F,1),1);
