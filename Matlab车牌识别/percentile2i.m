function g = percentile2i(h,p)
    if p < 0 || p > 1
        error('The percentile must be in the range [0,1]');
    end
    h = h/sum(h);
    c = cumsum(h);
    idx = find(c >= p,1,'first');
    g = (idx - 1)/(numel(h)-1);