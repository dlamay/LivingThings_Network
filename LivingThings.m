clear
clc

%input data and initialize input output
[num,raw,text]=xlsread('data.xls');
num_living_things=size(num,2);
input=eye(num_living_things);
output=transpose(num);

%set up network
num_input_units=length(input);
num_hidden_units = 10;
num_output_units=length(output);
rng(1);
s=rng;
syn0=2*rand(num_input_units,num_hidden_units)-1;
syn1=2*rand(num_hidden_units,num_output_units)-1;

ecrit= 1;
maxepochs=30000;

for j= drange(0:maxepochs)
    L0=input;
    L1=sigmoid((L0*syn0));
    L2=sigmoid((L1*syn1));
    
    L2_error=output - L2;
    
    L2_delta= L2_error.*sigmoid_deriv(L2);
    
    L1_error= L2_delta*(transpose(syn1));
    
    L1_delta=L1_error.*sigmoid_deriv(L1);
    
    syn1=syn1+ ((transpose(L1))*L2_delta);
    syn0=syn0+ ((transpose(L0))*L1_delta);
    
    if  mod(j,10000)==0
        fprintf('\nEpoch: %f\r',j)
        fprintf('total current error: %f\r',sum(sum(abs(L2_error))))
        fprintf('Error by living thing: \n')
        EbyLT=(transpose(sum((abs(L2_error)),2)));
        disp(EbyLT(1:8))
        disp(EbyLT(9:16))
    end
    
    if sum(sum(abs(L2_error)))< ecrit
        fprintf('\n error criterion met')
        break
    end
end

fprintf('\nLast epoch number: %f', j)
fprintf('\nTotal error at the end of training: %f', sum(sum(abs(L2_error))))
fprintf('\nError by living thing: \n')
EbyLT=(transpose(sum((abs(L2_error)),2)));
disp(EbyLT(1:8))
disp(EbyLT(9:16))

things=raw(1,:);
CGobj=clustergram(L1,'RowLabels',things(2:end),'Colormap',jet);


