read_data;
%{
net = cascadeforwardnet([16, 12], 'traingdm');
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';
net.trainParam.epochs=1500;
net.trainParam.goal=1E-4;
net.trainParam.time=60;

net = train(net, input, output);
view(net)
y = net(input)
%}


x = input;
t = output;

net = newff(x, t, [16, 12], {'logsig', 'logsig'});

net.trainFcn = 'trainoss';
net.performFcn = 'mse';
net.trainParam.epochs=2000; % Максимальна кількість епох
net.trainParam.goal=1E-4;

[net, tr] = train(net,x,t);
y = sim(net, x);
perf = perform(net,y,t);
counter = 1;
while perf > 0.1 && counter < 10
    net = init(net);
    net = train(net, x, t);
    y = net(x);
    perf = perform(net, y, t)
    counter = counter+1;
end

figure, plotconfusion(t,y)