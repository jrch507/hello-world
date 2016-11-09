function res = name_match(name1,name2)
% remove space and comma
string_remove = {' ',','};
for k = 1:numel(string_remove)
    idx1 = ~ismember(name1,string_remove{k});
    idx2 = ~ismember(name2,string_remove{k});
    name1 = name1(idx1);
    name2 = name2(idx2);
end
name1 = lower(name1);
name2 = lower(name2);
res = strcmp(name1,name2);
end