[x,t] = loaddata('images/train');
all_times = zeros(3, 7);

modifier = [0.5, 1, 1.5];
ts_avg = zeros(1, 3);
sigmas = zeros(1, 3);
deltas = zeros(1, 3); 
m1s = zeros(1, 3);
for i=1:3
    for j=1:7
        net = cascadeforwardnet([16*modifier(i), 12], 'traingdm');
        net.layers{1}.transferFcn = 'logsig';
        net.layers{2}.transferFcn = 'logsig';
        net.trainParam.epochs     = 1500;
        net.trainParam.time       = 60;
        net.trainParam.goal       = 1E-3;
        [net, tr] = train(net,x,t);
        all_times(i, j) = sum(tr.time);
    end
    ts_avg(i) = sum(all_times(i, :)) / 7;
    sigmas(i) = sqrt(sum((all_times(i, :) - ts_avg(i)).^2) / 7);
    s = sqrt(7/6) * sigmas(i);
    deltas(i) = 2.45 * s / sqrt(7);
    m1s(i) = 2.45^2 * s^2 / 0.1^2;
end

writetable(table([ts_avg',sigmas',deltas',m1s']), 'statistics_1E-3.xlsx');

