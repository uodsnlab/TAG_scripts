%% Extract Friend Names
cd /Volumes/psych-cog/dsnlab/TAG/behavior/task/info
files = dir('tag*wave_1_info.mat');

friend = cell(200,3);

for i = 1:length(files)
    fileName = files(i).name;
    load(fileName);  
    friend(i,1) = {drs.subID};
    friend(i,2) = {drs.friend};
    friend(i,3) = {drs.parent};
end

filename = fullfile('/Volumes/psych-cog/dsnlab/TAG/behavior/task/processed', 'friend.csv');
fid=fopen(filename, 'w');
fprintf(fid, '%s,%s,%s\n', 'SID','friend','parent');
for k=1:size(friend,1)
    fprintf(fid,'%s,%s,%s\n',friend{k,:});
end
fclose(fid);

%% Extract payment - incorrect for first half of participants.
cd /Volumes/psych-cog/dsnlab/TAG/behavior/task/output
files = dir('tag*wave_1_dsd_finalOut.mat');

payment = cell(200,3);

for i = 1:length(files)
    fileName = files(i).name;
    load(fileName);  
    subID = fileName(1:6);
    payment(i,1) = {subID};
    payment(i,2) = {discoInfo.payouts{1}};
    payment(i,3) = {discoInfo.payouts{2}};
end

filename = fullfile('/Volumes/psych-cog/dsnlab/TAG/behavior/task/processed', 'payments.csv');
fopen(filename, 'w');
fprintf(fid, '%s,%s,%s\n', 'SID','run1','run2');
for k=1:size(payment,1)
    fprintf(fid,'%s,%i,%i\n',payment{k,:});
end
fclose(fid);