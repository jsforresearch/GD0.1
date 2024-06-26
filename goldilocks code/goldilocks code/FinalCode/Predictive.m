 
function [r_path, r_cost] = Predictive(pathS, pathE, transmat) 

noOfNode = size(transmat, 1); 
for i = 1:noOfNode 
  parent(i) = 0; 
  distance(i) = inf; 
end 
queue = [];   
for i=1:noOfNode 
     
  if transmat(pathS, i)~=inf  
    distance(i) = transmat(pathS, i); 
    parent(i)   = pathS; 
    queue       = [queue i]; 
    
  end 
end
  
while length(queue) ~= 0 
   
  hopS  = queue(1); 
  queue = queue(2:end); 
   
  for hopE = 1:noOfNode 
      if distance(hopE) > (distance(hopS) + transmat(hopS,hopE)) 
      distance(hopE) = distance(hopS) + transmat(hopS,hopE); 
      parent(hopE)   = hopS; 
      queue          = [queue hopE];  
    end 
  end 
  
end 
distance 
r_path = [pathE];     
i = parent(pathE); 
while i~=pathS && i~=0 
  r_path = [i r_path]; 
  i      = parent(i) 
end 
  
if i==pathS 
  r_path = [i r_path]; 
else 
  r_path = []; 
end 
r_cost = distance(pathE); 