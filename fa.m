clc;
clear;
close all;
global Max_x1 Min_x1 Max_x2 Min_x2 Max_y1 Min_y1  Max_y2 Min_y2
%%
Max_x1=input('plz enter Max x1 = ');
Min_x1=input('plz enter Min x1 = ');
disp('-------------------------------------')
Max_x2=input('plz enter Max x2 = ');
Min_x2=input('plz enter Min x2 = ');
disp('-------------------------------------')
Max_y1=input('plz enter Max y1 = ');
Min_y1=input('plz enter Min y1 = ');
disp('-------------------------------------')
Max_y2=input('plz enter Max y2 = ');
Min_y2=input('plz enter Min y2 = ');
disp('-------------------------------------')
%
%% 
CostFunction=@(x) CF(x);        
nVar=1;                
VarSize=[1 nVar];      
VarMin=Min_x1;         
VarMax=Max_x1;      
%% 
MaxIt=100;          
nPop=40;            
gamma=1;            
beta0=2;           
alpha=0.2;         
alpha_damp=0.99;    
delta=0.05*(VarMax-VarMin);     
m=2;
%% 
firefly.Position=[];
firefly.Cost=[];
% 
pop=repmat(firefly,nPop,1);
% 
BestSol.Cost=inf;
% 
for i=1:nPop
   pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
   pop(i).Cost=CostFunction(pop(i).Position); 
   if pop(i).Cost<=BestSol.Cost
       BestSol=pop(i);
   end
end
% 
BestCost=zeros(MaxIt,1);
%% 
for it=1:MaxIt   
    newpop=pop;
    for i=1:nPop
        for j=1:nPop
            if pop(j).Cost<=pop(i).Cost
                rij=norm(pop(i).Position-pop(j).Position);
                beta=beta0*exp(-gamma*rij^m);
                e=delta*unifrnd(-1,+1,VarSize);
                %   
                newpop(i).Position=pop(i).Position...
                    +beta*(pop(j).Position-pop(i).Position)...
                    +alpha*e;    
                newpop(i).Position=max(newpop(i).Position,VarMin);
                newpop(i).Position=min(newpop(i).Position,VarMax);
                newpop(i).Cost=CostFunction(newpop(i).Position);
                if newpop(i).Cost<=BestSol.Cost
                    BestSol=newpop(i);
                end
            end
        end
    end
    %
    pop=[pop
         newpop
         BestSol];  
    % 
    [~, SortOrder]=sort([pop.Cost]);
    pop=pop(SortOrder);
    pop=pop(1:nPop);
    BestCost(it)=BestSol.Cost;
    alpha=alpha*alpha_damp;   
end
%% 
figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Fit');
title('Firefly Algorithm Optimization')
grid minor
%%
x1=BestCost(end);
x2=(BestCost(end)*(Max_x2-Min_x2))/(Max_x1-Min_x1);
y1=(BestCost(end)*(Max_y1-Min_y1))/(Max_x1-Min_x1);
y2=(BestCost(end)*(Max_y2-Min_y2))/(Max_x1-Min_x1);
func=((x1-x2)^2)+((y1-y2)^2);
disp('--------------------------------------------------')
disp('| Result |')
disp('--------------------------------------------------')
disp(['Best x1 = ',num2str(x1)])
disp(['Best x2 = ',num2str(x2)])
disp(['Best y1 = ',num2str(y1)])
disp(['Best y2 = ',num2str(y2)])
disp(['Minimum((x1-x2)^2+((y1-y2)^2)= ',num2str(func)])