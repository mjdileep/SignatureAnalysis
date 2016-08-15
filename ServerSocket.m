function data=ServerSocket(conn,table,column,intervalSize,deviceID)
    endTime=datestr(datetime('now'),'yyyy-mm-dd HH:MM:SS');
    startTime=datestr(datetime('now')-minutes(intervalSize),'yyyy-mm-dd HH:MM:SS');
    query=['SELECT ' column ' FROM ' table ' where code = ' deviceID ' and date_time between ''' startTime ''' and ''' endTime ''' ORDER BY date_time DESC'];
    curs = exec(conn,query);
    curs = fetch(curs);
    data = curs.Data;
    close(curs);
    close(conn);
     
end