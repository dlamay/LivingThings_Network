%AND function
%variables 
input = [1 1; 1 0; 0 1; 0 0];%[0.9 0.1; 0.1 0.9; 1 0; 1 1];
numIn= 4;
expected_out = [0;1;1;1];
bias= .1;
Lrate= .1;
weights =[1 ;-.1 ;-.2];%;-1*2.*rand(3,1);
iterations= 3;

%feed forward
for i= 1:iterations
    out = zeros (4,1);
    for j= 1:numIn
          y=bias*weights(1,1)+input(j,1)*weights(2,1)+input(j,2)*weights(3,1);
          out(j) = 1/(1+exp(-y));
          delta= expected_out(j)-out(j);
          weights(1,1)=weights(1,1)+Lrate*bias*delta;
          weights(2,1)=weights(2,1)+Lrate*input(j,1)*delta;
          weights(3,1)=weights(3,1)+Lrate*input(j,2)*delta;
    end
end

