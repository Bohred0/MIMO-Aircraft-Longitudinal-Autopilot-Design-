function Ts = settling_time(t, val, tol, ref)

% Default reference = 0
if nargin < 4
    ref = 0;
end

idx = find(abs(val - ref) > tol);

if isempty(idx)

    Ts = 0;

elseif idx(end) == length(val)

    Ts = NaN;

else

    Ts = t(idx(end) + 1);

end

end
