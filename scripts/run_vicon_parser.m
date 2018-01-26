%% Script to process entire collection of vicon data
%     AUTHOR    : Joseph Robinson
%     DATE      : January-2018
%     Revision  : 1.0
%     DEVELOPED : 2017b
%     FILENAME  : run_vicon_parser.m
d1 = dir('../Vicon_Nexus_data/*/*.csv');
obin = '../parsed_vicon/';
obins = strcat(obin, {'emg/', 'skeleton/'});

cellfun(@utils.checkdir, obins)

nfiles = length(d1);
fpaths = strcat({d1.folder}, '/', {d1.name});
fout_emg = strcat(obins{1}, {d1.name});
fout_skel = strcat(obins{2}, {d1.name});

parfor x = 1:nfiles
    % each vicon file
    
    if exist(fout_emg{x},'file')
        continue
    end
    try
        [emg_table, skel_table] = parse_vicon(fpaths{x});
        writetable(emg_table, fout_emg{x}, 'Delimiter',',');
        writetable(skel_table, fout_skel{x}, 'Delimiter',',');
    catch e
        fprintf(1, 'WARNING: [%d] %s thrown exception', x, fpaths{x});
    end
    
end
