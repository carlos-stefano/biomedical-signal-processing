function [A] = motif_to_adjacency(dataMotif,inicio,fim)
% Builds adjacency matrix from motifs series
% Inputs: "dataMotif" - motif series. nSamples x nBlocks x nChannels matrix.
%         "start" - point to start counting comparisons
%         "end" - point to end counting comparisons    
% Output: "A": adjacency matrix (weighted)
nBlocks = size(dataMotif,2);
nChan = size(dataMotif,3);
A = zeros(nChan,nChan,nBlocks);
for bloco = 1:nBlocks
    for canalfixo = 1:nChan
        for canalcompara = 1:nChan
            % j indicates motifs matching
            j= 0;
            for amostra = inicio:fim
                if canalcompara ~= canalfixo
                    if dataMotif(amostra,bloco,canalcompara) == dataMotif(amostra,bloco,canalfixo)
                        j = j + 1;
                    end
                end    
            end
            A(canalfixo,canalcompara,bloco) = j;
        end
    end
end
end