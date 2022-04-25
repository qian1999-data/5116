% Inputs :
% f: forward spot for time T, i.e. E[S(T)]
% T: time to expiry of the option
% Ks: vector of strikes
% Vs: vector of implied Black volatilities
% Output :
% u: vector of call options undiscounted prices
function u = getBlackCall(f,T,Ks,Vs)
    if ~isequal(numel(Ks),numel(Vs))
        error('getBlackCall:UnequalSize','Ks and Vs must be equal in size!!, please check the inputs');
    else if (f<0) || (T<0) || any(Ks<0) || any(Vs<0)
        error('getBlackCall:InputNonNegative','forward price, time, strike and vol must be non-negative!! Please check the inputs');
    end
    x = Vs.*sqrt(T);
    d1 = (log(f)-log(Ks))./x+0.5.*x;
    d2 = d1 - x;
    u = f*normcdf(d1) - Ks.*normcdf(d2);
end

