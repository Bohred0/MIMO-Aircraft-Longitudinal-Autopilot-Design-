function Ts = settling_time(t,val,tol)

idx = find(abs(val) > tol);

if isempty(idx)

    Ts = 0;

elseif idx(end) == length(val)

    Ts = NaN;

else

    Ts = t(idx(end)+1);

end

end
