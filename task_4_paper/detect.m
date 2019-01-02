function [eigVectNoise] = detect(obj, nSources)
% Function: 
%   - detect the generalised noise eigenvectors based on eigendecomposition
%
% InputArg(s):
%   - obj: smoothed covariance matrix of signal
%   - nSources: number of sources estimated
%
% OutputArg(s):
%   - eigVectNoise: generalised noise eigenvectors
%
% Restraints:
%   - Traditional detection is based on observations, where the criterion
%   of regarding a eigenvalue as 'small' corresponding to noise is
%   determined by noise power. In this case we use a simplified model based
%   on comparison: the threshold is defined manually since the noise power
%   is unknown. The precision of this function needs improvements.
%
% Comments:
%   - also obtain noise eigenvector to create subspace for MUSIC algorithm
%
% Author & Date: Yang (i@snowztail.com) - 30 Dec 18

[eigVector, eigValue] = eig(obj);
eigValue = abs(diag(eigValue));
% eigVectNoise = eigVector(:, 1: end - nSources);
% eigVectNoise = eigVector(:, 1: 178);

% signal and noise eigenvalue threshold
eigNoiseThr = 0.01;
% % estimated source number
% nSourcesEst = sum(eigValue > eigNoiseThr);
% signal eigenvector
eigVectSignal = eigVector(:, eigValue > eigNoiseThr);
% generalised noise eigenvector
eigVectNoise = fpoc(eigVectSignal);
end
