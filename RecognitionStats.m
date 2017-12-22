[x,t] = loaddata('images/train');
all_times = zeros(3, 7);
modifier = 0;
ts = zeros(1, 3);
sigmas = zeros(1, 3);
deltas = zeros(1, 3); 
ms = zeros(1, 3);
for i=1:3
    times = zeros(1, 7);
    for j=1:7
        net = newff(x, t, [16 6+modifier], {'logsig', 'logsig'});

        net.trainFcn = 'trainoss';
        net.performFcn = 'mse';
        net.trainParam.epochs=2000;
        net.trainParam.goal=1E-3;

        [net, tr] = train(net,x,t);
        times(j) = sum(tr.time);
    end
    all_times(i, ? = times(:);

    modifier = modifier+6;
end

[input, output] = 
k=[12, 16, ]
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