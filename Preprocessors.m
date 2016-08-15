function points=fillMissingValues(dataSet)
n=size(dataSet);
points=zeros(n);
avg=0;
notNullCount=0;
for i=1:n(2)
    if ~STRCMP(dataset(i),'null')
        avg=avg+str2double(dataset(i));
        notNullCount=notNullCount+1;
    end
end
avg=avg/notNullCount;
for i=1:n(2)
    if STRCMP(dataset(i),'null')
        points(i)=avg;
    else 
        points(i)=str2double(dataset(i));
    end
end