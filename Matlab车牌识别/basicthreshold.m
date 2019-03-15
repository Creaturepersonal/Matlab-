function g = basicthreshold(f)
    w = fspecial('average',9);
    f = imfilter(f,w,'replicate');
    count = 0;
    T = mean2(f);
    done = false;
    while ~done
        count = count + 1;
        g = f > T;
        tnext = 0.5*(mean(f(g)) + mean(f(~g)));
        done = abs(T - tnext);
        T = tnext;
    end
    g = im2bw(f,T/255);
end