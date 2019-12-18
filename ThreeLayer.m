%XOR function
%variables 
input = [0 0; 0 1; 1 0; 1 1];
output = [0;1;1;0];
bias= [-.5,-.5,-.5];
Lrate= .7;
weights = -1*2.*rand(3,3);
iterations=10000;

%feed forward
for i= 1:iterations
    out = zeros (4,1);
    numIn=length (input(:,1));
    for j= 1:numIn
        %hidden layer
        H1=bias(1,1)*weights(1,1)+input(j,1)*weights(1,2)...
        +input(j,2)*weights(1,3);
        x2(1)=1/(1+exp(-H1));
        H2= bias(1,2)*weights(2,1)+input(j,1)*weights(2,2)...
        +input(j,2)*weights(2,3);
        x2(2)=1/(1+exp(-H2));
        
        %output layer
        x3_1=bias(1,3)*weights(3,1)+x2(1)*weights(3,2)+x2(2)*weights(3,3);
        out(j)=1/(1+exp(-x3_1));
        
        
        
        delta3_1=out(j)*(1-out(j))*(output(j)-out(j));
        
        delta2_1=x2(1)*(1-x2(1))*weights(3,2)*delta3_1;
        delta2_2=x2(2)*(1-x2(2))*weights(3,3)*delta3_1;
       
        
        for k= 1:3
            if k== 1 %bias cases
                weights(1,k)= weights(1,k)+Lrate*bias(1,1)*delta2_1;
                weights(2,k)= weights(2,k)+Lrate*bias(1,2)*delta2_2;
                weights(3,k)= weights(3,k)+Lrate*bias(1,3)*delta3_1;
            else %when k=2 or 3 input cases to neurons
                weights(1,k)= weights(1,k)+Lrate*input(j,1)*delta2_1;
                weights(2,k)= weights(2,k)+Lrate*input(j,2)*delta2_2;
                weights(3,k)= weights(3,k)+Lrate*x2(k-1)*delta3_1;
            end
        end    
    end
end
