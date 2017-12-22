load('net_goal_1E-4');
[input, target] = loaddata('images/test');
out = net(input);
out(5:8,:)= target;
tbl = table(out');
writetable(tbl, 'net_goal_1E-4.xls');