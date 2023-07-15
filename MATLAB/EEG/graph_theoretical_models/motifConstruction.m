function [motif_synchronization_matrix] = motifConstruction(data)
% Translates EEG time series into three-points motif series, with no lag, as proposed by Rosário et al. (2015) (https://doi.org/10.1016/j.physa.2015.07.018)
% Input: data - NSamples x nBlocks x nChannels input EEG data matrix
% Output: 
blockSamples = size(data,1);
nBlocks = size(data,2);
nChan = size(data,3);
nmotif = 3; % number of data points to consider for the motif series
motif_synchronization_matrix = zeros(blockSamples - nmotif + 1,nBlocks,nChan);
for channel = 1:nChan
    for time_period_block = 1:nBlocks
%         data(:,time_period_block,channel) = smooth(data(:,time_period_block,channel));
        for i = 1:(blockSamples - nmotif + 1)
            if data(i,time_period_block,channel) > data(i+1,time_period_block,channel) && data(i+1,time_period_block,channel) > data(i+2,time_period_block,channel)
                motif_synchronization_matrix(i,time_period_block,channel) = 1;
            end
            if data(i,time_period_block,channel) > data(i+1,time_period_block,channel) && data(i+1,time_period_block,channel) < data(i+2,time_period_block,channel) && data(i,time_period_block,channel) > data(i+2,time_period_block,channel)
                motif_synchronization_matrix(i,time_period_block,channel) = 2;
            end
            if data(i,time_period_block,channel) < data(i+1,time_period_block,channel) && data(i+1,time_period_block,channel) > data(i+2,time_period_block,channel) && data(i,time_period_block,channel) > data(i+2,time_period_block,channel)
                motif_synchronization_matrix(i,time_period_block,channel) = 3;
            end
            if data(i,time_period_block,channel) > data(i+1,time_period_block,channel) && data(i+1,time_period_block,channel) < data(i+2,time_period_block,channel) && data(i,time_period_block,channel) < data(i+2,time_period_block,channel)
                motif_synchronization_matrix(i,time_period_block,channel) = 4;
            end
            if data(i,time_period_block,channel) < data(i+1,time_period_block,channel) && data(i+1,time_period_block,channel) < data(i+2,time_period_block,channel)
                motif_synchronization_matrix(i,time_period_block,channel) = 5;
            end
            if data(i,time_period_block,channel) < data(i+1,time_period_block,channel) && data(i+1,time_period_block,channel) > data(i+2,time_period_block,channel) && data(i,time_period_block,channel) < data(i+2,time_period_block,channel)
                motif_synchronization_matrix(i,time_period_block,channel) = 6;
            end
        end
    end
end
end

