[input, output] = loaddata('images/train');

%net = newcf(input,output,[16 12],{'tansig','logsig'});
net = cascadeforwardnet([16, 12], 'traingdm');
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';
net.trainParam.epochs     = 1500;
net.trainParam.time       = 60;
% use 1E-2, 1E-3, 1E-4
net.trainParam.goal = 1E-4;
y = zeros(4, 20);
while confusion(output, y) > 0.1
    net = init(net);
    [net, tr] = train(net, input, output);
    y = net(input);
end

save('net_goal_1E-4');

%view(net);
