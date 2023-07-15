function [carData] = carFiltering2(input_signal)
% Applies Common Average Referencing (CAR) to the EEG signals in 'input_signal'
% Input: input_signal - nSamples x nChannels input matrix
% Output: carData - filtered data following CAR
    chNumber = size(input_signal,2);
    dataSumElectrode = sum(input_signal,2)/chNumber;
    dataCat = [];
    for k = 1:chNumber
        dataCat = cat(2,dataCat,dataSumElectrode);
    end
    carData = input_signal-dataCat;
end