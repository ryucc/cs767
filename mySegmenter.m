function [imOut, bdd_points, bdd_length, Area, diameter] = mySegmenter(imIn,fill)
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
		cw = w.*count;

		intraVar = zeros(1,255);	
		t1 = count(1);
		t2 = sum(count(2:256));
		w1 = cw(1);
		w2 = sum(cw(2:256));
		a1 = w1/t1;
		a2 = w2/t2;
		intraVar(1) = (t1/total)*(t2/total)*(a1-a2)^2;
		for i = 2:255
			t1 = t1+count(i);
			t2 = t2-count(i);
			w1 = w1+count(i);
			w2 = w2-count(i);
			a1 = w1/t1;
			a2 = w2/t2;
			intraVar(i) = (t1/total)*(t2/total)*(a1-a2)^2;
		end
		%get max intraVar
		[x,y] = max(intraVar);
		imOut = imIn>y;
	else
        % create spectrum
		[a,b] = size(imIn);
		v = reshape(imIn,[a*b,1]);
		v = sort(v);
		len = a*b;
		intraVar = zeros(1,len-1);	
		w1 = v(1);
		w2 = sum(v(2:end));
		a1 = w1;
		a2 = w2/(len-1);
		intraVar(1) = (1/len)*((len-1)/len)*(a1-a2)^2;
		for i=2:len-1
			w1 = w1 + v(i);
			w2 = w2 - v(i);
			a1 = w1/i;
			a2 = w2/(len-i);
			intraVar(i) = (i/len)*((len-i)/len)*(a1-a2)^2;
		end
		%get max intraVar
		[x,y] = max(intraVar);
		imOut = imIn>v(y);
	end
	[bdd_points, bdd_length, Area, diameter] = myPerimeter(imOut);
	if nargin > 1
		imOut = myFill(imOut);
	end
end
