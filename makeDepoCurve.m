% Inputs:
%	   ts: array of size N containing times to settlement in years
%    dfs: array of size N discount factors
% Output:
%	   curve: a struct containing data needed by getRateIntegral
function curve = makeDepoCurve(ts, dfs)
  if ~isequal(numel(ts), numel(dfs))
    error("the size of ts and dfs must be equal");
  end
  dfs = log(dfs);
  forwardRates = [
    -dfs(1)/ts(1)
    (dfs(1:end-1) - dfs(2:end)) ./ (ts(2:end) - ts(1:end-1))
  ];
  % extrapolate once for rates beyond 30 days after last tenor
  curve = struct('ts', [ts; ts(end)+(30/365)], 'rates', [forwardRates; forwardRates(end)]);
end
