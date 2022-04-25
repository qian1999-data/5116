% Inputs:
%    curve: pre-computed data about an interest rate curve
%    t: time
% Output:
%    integ: integral of the local rate function from 0 to t
function integ = getRateIntegral(curve, t)
  if t > curve.ts(end)
    error('getRateIntegral:BeyondTenorError', 'time exceeds the last tenor');
  elseif t < 0
    error('getRateIntegral:NegativeTimeError', 'time should be positive');
  end
  i = upperBound(curve.ts, t);
  
  ts = [0; curve.ts(1:i-1); t];
  area = (ts(2:end) - ts(1:end-1)) .* curve.rates(1:i);
  integ = sum(area);
end

function index = upperBound(arr, x)
  l = 1;
  u = numel(arr);
  while l < u
    m = fix((l+u)/2);
    if arr(m) >= x
      u = m;
    else
      l = m+1;
    end
  end
  index = u;
end