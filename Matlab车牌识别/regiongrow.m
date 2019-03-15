function [gr,NR,SI,TI] = regiongrow(f,S,T)
    f = tofloat(f);
    if numel(S) == 1
        SI = f == S;
        S1 = S;
    else
        SI = bwmorph(S,'shrink',Inf);
        S1 = f(SI);
    end
    TI = false(size(f));
    for k = 1:length(S1)
        seedvalue = S1(k);
        S = abs(f - seedvalue) <= T;
        TI = TI | S;
    end
    [gr,NR] = bwlabel(imreconstruct(SI,TI));