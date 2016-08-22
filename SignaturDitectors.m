conn=database.ODBCConnection('SignatureAnalysis','dileep','dileep@123');
while true
    
    if ~isopen(conn)
        conn=database.ODBCConnection('SignatureAnalysis','dileep','dileep@123');
    end
    table='classes';
    column='code,interval';
    query=['SELECT ' column ' FROM ' table ' where train = 1'];
    curs = exec(conn,query);
    curs = fetch(curs);
    data = curs.Data;
    close(curs);
    classValues=cell2mat(classDataSet);
    [n p]=size(classValues);
    for i=1:n
        id =['x' num2str(classValues(i,1))];
        timePeriod=classValues(i,2);%in 5mins
        noOfPoints=25; %#of points 
        intevalSize=30; %size of accumilation interval
        try
            load(id);
        catch ex
            net=feedforwardnet(10);
        end
        net=Train(net,conn,timePeriod,noOfPoints,num2str(classValues(i,1)),intevalSize);
        save(id,'net');
        %set status
        query=['UPDATE ' table ' SET train = 0 where code = ' num2str(classValues(i,1))];
        if ~isopen(conn)
            conn=database.ODBCConnection('SignatureAnalysis','dileep','dileep@123');
        end
        curs = exec(conn,query);
        curs = fetch(curs);
        data = curs.Data;
        close(curs);
    end
    pause(60);
    
end
% net = feedforwardnet(10);
% timePeriod=10; %training period
% noOfPoints=30; %#of points 
% deviceID='1082'
% intevalSize=30; %size of accumilation interval
% i=0;
% while i<100
% net=Train(net,conn,timePeriod,noOfPoints,deviceID,intevalSize);
% i=i+1;
% end
