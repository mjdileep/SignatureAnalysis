function data = ClassSocket(conn,deviceID)
%CLASSSOCKET Summary of this function goes here
%   Detailed explanation goes here
    if ~isopen(conn)
      conn=database.ODBCConnection('SignatureAnalysis','dileep','dileep@123');
    end
    table='classes';
    column='c1,c2,c3,c4,c5';
    query=['SELECT ' column ' FROM ' table ' where code = ' deviceID];
    curs = exec(conn,query);
    curs = fetch(curs);
    data = curs.Data;
    close(curs);

end

