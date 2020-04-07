% this is the ver1.0 of the npv model
function npv_value = Rnpv(x, delta, n)
if delta > 1
    error("delta must be smaller than 1");
end

npv_value = 0;
for i = 1:n
    cur_value = Rcur(x);
    npv_value = npv_value + delta^(i-1) * cur_value;
end
end