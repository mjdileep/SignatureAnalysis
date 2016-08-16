function NN=Train(net,conn,timePeriod,noOfPoints,deviceID,intevalSize)%NB:- deviceID is A STRING
    %most resent values are at the last of the array
    classSet='c1,c2,c3,c4,c5';
    resultColumn='ph1_active_energy';
    dataTable='powerpro';
    classTable='classes';
    while timePeriod>0
        classDataSet=ServerSocket(conn,classTable,classSet,intevalSize,deviceID);%getting class values from DB
        dataSet=ServerSocket(conn,dataTable,resultColumn,intevalSize,deviceID);%getting column values from DB
        classValues=cell2mat(classDataSet);
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
        end;
        classes=classValues';
        net = train(net,intertia',classes);
       
       % pause(60*5);
        timePeriod=timePeriod-5;
    end
    NN=net;
end