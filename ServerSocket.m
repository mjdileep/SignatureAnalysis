function data=ServerSocket(conn,table,column,intervalSize,deviceID)
    if ~isopen(conn)
       conn=database.ODBCConnection('SignatureAnalysis','dileep','dileep@123');
    end
    endTime=datestr(datetime('now'),'yyyy-mm-dd HH:MM:SS');
    startTime=datestr(datetime('now')-minutes(intervalSize),'yyyy-mm-dd HH:MM:SS');
    query=['SELECT ' column ' FROM ' table ' where code = ' deviceID ' and date_time between ''' startTime ''' and ''' endTime ''' ORDER BY date_time ASC'];
    curs = exec(conn,query);
    curs = fetch(curs);
    data = curs.Data;
    close(curs);
     
end
