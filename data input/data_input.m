clc;
clear all;
close all;


%% input SEP 
file_path = strcat(pwd,'\');
file_name = strcat(file_path,'data_test.xlsx');
sheet_name = 'SEP Table';

% ---read names and existing data--------
% ** read existing data is to avoid overwrite to existing data **
% 
disp('Reading data...');
[num,txt,name_xls] = xlsread(file_name,sheet_name,'C4:C84');
[num,txt,data_exist_xls] = xlsread(file_name,sheet_name,'G4:M84');

row_num_str = 3;  % start row number of the selected range
col_num_str = 4;  % start column number of the selected range
row_num_off = 0;  % offset of row number
col_num_off = 0;  % offset of column number

slice_xls = data_exist_xls(:,7);
L_LN19_xls = data_exist_xls(:,1);
L_LP23_xls = data_exist_xls(:,2);
L_Amp_xls = data_exist_xls(:,3);
R_LN19_xls = data_exist_xls(:,4);
R_LP23_xls = data_exist_xls(:,5);
R_Amp_xls = data_exist_xls(:,6);

N_xls = numel(name_xls);
% ---input values------
N = 200;
name = cell(N,1);
slice = zeros(N,1);
L_LN19 = zeros(N,1);
L_LP23 = zeros(N,1);
L_Amp = zeros(N,1);
R_LN19 = zeros(N,1);
R_LP23 = zeros(N,1);
R_Amp = zeros(N,1);

name_miss = {};
num = 1;
disp('Please input corresponding information. Input ''stop'' as name to end this procedure.');
for k=1:N
    try
        % ------input value-----------------
        name{k} = input('name:','s');
        if strcmp(name{k},'stop')
            break;
        end
        slice(k) = str2double(input('slice:','s'));
        L_LN19(k) = str2double(input('Left N19:','s'));
        L_LP23(k) = str2double(input('Left P23:','s'));
        L_Amp(k) = str2double(input('Left Amp:','s'));
        R_LN19(k) = str2double(input('Right N19:','s'));
        R_LP23(k) = str2double(input('Right P23:','s'));
        R_Amp(k) = str2double(input('Right Amp:','s'));
        
        % ------find name in excel file--------
        sign_name = zeros(1,N);
        for k_x = 1:N_xls
            sign_name(k_x) = name_match(name_xls{k_x},name{k});
        end
        idx = find(sign_name==1);
        if isempty(idx)
            name_miss{num} = name{k};
            num = num+1;
            msg = strcat('''',name{k},''' is not found!');
            disp(msg);
        else
            if ~isnan(L_LN19_xls{idx}) && L_LN19_xls{idx}>0
                msg = strcat('Overwrite the existing results for ''',name_xls{idx},'''? Y/N:');
                isoverwrite = input(msg,'s');
                if strcmp(isoverwrite,'N')
                    continue;
                end
            end
            slice_xls(idx) = {slice(k)};
            L_LN19_xls(idx) = {L_LN19(k)};
            L_LP23_xls(idx) = {L_LP23(k)};
            L_Amp_xls(idx) = {L_Amp(k)};
            R_LN19_xls(idx) = {R_LN19(k)};
            R_LP23_xls(idx) = {R_LP23(k)};
            R_Amp_xls(idx) = {R_Amp(k)};
        end
      
        
    catch ME
        name{k} = 'error';
        disp('error');
    end
end

% ----------write excel---------------------
write_range = 'G4:M84';
data_xls = [L_LN19_xls,L_LP23_xls,L_Amp_xls,R_LN19_xls,R_LP23_xls,R_Amp_xls,slice_xls];
while(1)
try
    disp('The data is writing...');
    xlswrite(file_name,data_xls,sheet_name,write_range);
    break;
catch ME
    disp('Please close the excel file and press enter button!');
    tmp = input('','s');
    continue;
%     disp('The data is writing...');
%     xlswrite(file_name,data_xls,sheet_name,write_range);
end
end
