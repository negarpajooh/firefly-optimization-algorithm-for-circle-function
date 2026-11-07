function  z=CF(x)
global NFE Max_x1 Min_x1 Max_x2 Min_x2 Max_y1 Min_y1  Max_y2 Min_y2
if isempty(NFE)
   NFE=0;
end
NFE=NFE+1;
%%
x1=x;
x2=(Max_x2-Min_x2)/(Max_x1-Min_x1);
y1=(Max_y1-Min_y1)/(Max_x1-Min_x1);
y2=(Max_y2-Min_y2)/(Max_x1-Min_x1);
%%
z=(x1-x2).^2-(y1-y2).^2;
end