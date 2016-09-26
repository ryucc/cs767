function [imOut] = mySegmenter(imIn,method)
	imOut = 0;
	if islogical(imIn)
		imOut = imIn;
	elseif isinteger(imIn)
        % create spectrum
		count = zeros(1,256);
        for i = 1:256
            count(i) = sum(sum(imIn == i-1));
        end

        % weight
		total = sum(count);
        w = 0:1:255;
		% avg = sigma{ f(i) * ni / tot}
		% sig = sigma{ f(i).^2 * ni / tot}
		cw = w.*count;

	%	unused inter-class varience
	%	cw2 = w.^2.*count;
	%
	%	interVar = zeros(1,255);
	%	for i = 1:255
	%		t1 = sum(count(1:i));
	%		t2 = sum(count(i+1:256));
	%		w1 = sum(cw(1:i));
	%		w2 = sum(cw(i+1:256));
	%		s1 = sum(cw2(1:i));
	%		s2 = sum(cw2(i+1:256));
	%		
	%		a1 = w1/t1;
	%		sg1 = s1/t1;
	%		a2 = w2/t2;
	%		sg2 = s2/t2;
    %
	%		var1 = sg1 - a1^2;
	%		var2 = sg2 - a2^2;
	%
	%		interVar(i) = (t1/(t1+t2))*var1+(t2/(t1+t2))*var2;
	%	end

		intraVar = zeros(1,255);	
		for i = 1:255
			t1 = sum(count(1:i));
			t2 = sum(count(i+1:256));
			w1 = sum(cw(1:i));
			w2 = sum(cw(i+1:256));
			a1 = w1/t1;
			a2 = w2/t2;
			intraVar(i) = (t1/total)*(t2/total)*(a1-a2)^2;
		end

		%get max intraVar
		[x,y] = max(intraVar);
		imOut = imIn>=y;
	end
end
