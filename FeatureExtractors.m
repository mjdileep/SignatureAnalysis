function featute = getNthMoment(points,index,n,unitSize)
%All the missing values in set points has to be filled
feature=0;
[a,i]=size(points);
while i>1
    j=i-1;
    blockDistance=0.0;
    triangaleDistance=0.0;
    if index<i
        blockDistance=index-1*i+0.5;
        if points(j)>point(i)
            triangaleDistance=index-1*i+(2/3);
        else
            triangaleDistance=index-1*i+(1/3);
        end
    elseif index>i
        blockDistance=index-i+0.5;
        if points(j)>point(i)
            triangaleDistance=index-i+(2/3);
        else
            triangaleDistance=index-i+(1/3);
        end
    else
        blockDistance=0.5;
        if points(j)>point(i)
            triangaleDistance=(2/3);
        else
            triangaleDistance=(1/3);
        end
    end
    feature=feature+((blockDistance*unitSize)^n)*min(points(i),points(j))*unitSize+((triangaleDistance*unitSize)^n)*abs(points(i)-points(j))/2*unitSize;
    i=i-1;
end

    

end