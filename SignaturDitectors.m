
conn=database.ODBCConnection('SignatureAnalysis','dileep','dileep@123');
net = feedforwardnet(10);
timePeriod=10; %training period
noOfPoints=30; %#of points 
deviceID='1082'
intevalSize=30; %size of accumilation interval
i=0;
while i<100
net=Train(net,conn,timePeriod,noOfPoints,deviceID,intevalSize);
i=i+1;
end