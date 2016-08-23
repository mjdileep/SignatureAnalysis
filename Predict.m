function results = Predict(conn, deviceID )
    id =['x' deviceID];
    try
       load(id);
    catch ex
       print('no trained net for the given device');
    end
    resultColumn='ph1_active_energy';
    dataTable='powerpro';
    noOfPoints=25; %#of points 
    intevalSize=30; %size of accumilation interval
    dataSet=ServerSocket(conn,dataTable,resultColumn,intevalSize,deviceID);%getting column values from DB
    dataPointsTemp=cell2mat(dataSet);
    [t2,~]=size(dataPointsTemp);
    dataPoints=zeros(1,t2-1);
    dataFiltered=zeros(1,noOfPoints);
    [~,b]=size(dataPoints);
    avg=0.0;
    for i=2:t2
        dataPoints(i-1)=dataPointsTemp(i)-dataPointsTemp(i-1);
        avg=avg+dataPoints(i-1);
    end
    avg=avg/(b-1);
    if b>=noOfPoints
        for i=1:noOfPoints
            dataFiltered(i)=dataPoints(i+b-noOfPoints);
        end
    else 
        for i=noOfPoints-b+1:noOfPoints
            dataFiltered(i)=dataPoints(i-(noOfPoints-b));
        end 
        for i=1:noOfPoints-b
            dataFiltered(i)=avg;
        end

    end
    intertia=zeros(1,noOfPoints);
    for i=1:noOfPoints
        intertia(i)=getNthMoment(dataFiltered,i,2,1);
    end
    results = net(intertia');
end

