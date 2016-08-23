function n = Deploy()
    deviceID='1082'
    conn=database.ODBCConnection('SignatureAnalysis','dileep','dileep@123');
    while true
        print(Predict(conn,deviceID));
        pause(60);
    end

end

