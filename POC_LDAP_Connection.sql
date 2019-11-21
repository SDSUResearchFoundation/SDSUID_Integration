--********************************************************************************************************************************
/********************************************************************************************************************************

POC Purpose:
The purpose of this POC is to demostrate the new aproach to connect from SDSU LDAP Server to Foundation ORACLE Databases.
This Aproach uses OpenLDAP Client installed on the ORACLE Database Server.
LDAP Documentation available at: https://www.openldap.org/software/man.cgi?query=ldapsearch

POC Created by: Heylin Ramirez  on 11/20/2018

POC Details of the Required Parameters:
/usr/bin/ldapsearch -> Commands on the DB Server
-H -> Specify URI(s) referring to the ldap server(s) ->  LDAP URL is a string that can be used to encapsulate the address and port of a directory server  https://www.openldap.org/software/man.cgi?query=ldapsearch
ldaps://idldap.sdsu.edu -> AD hostName 
-D bind DN (user who is allowed to read entries from the database)
CN=sdf-svc-myrf -> Username defined in lastpass and is allowed to read to Campus AD Database.
OU=Service Accounts,OU=SDF,OU=AX,OU=Delegated OUs,DC=id,DC=sdsu,DC=edu" 
-w "Password in LastPAss for username=sdf-svc-myrf " 
-b "OU=Employees,OU=People,DC=id,DC=sdsu,DC=edu"    DC= Domain Component
"(EmployeeNumber=817465552)"

Notes:
Before Executing this Code make sure to replace the Password with the Correct one located on LastPass

All available LDAP commands are located under /usr/local as ORACLE user:
ldapadd
ldapcompare
ldapdeleteldapexop
ldapmodify
ldapmodrdn
ldappasswd
ldapsearch
ldapurl
ldapwhoami

**Restrictions:
This is only available on TEST instances.
*/


SET SERVEROUTPUT ON SIZE 1000000
CALL DBMS_JAVA.SET_OUTPUT(1000000);

DECLARE
  l_output DBMS_OUTPUT.chararr;
  l_lines  INTEGER := 1000;
 l_string VARCHAR2(10000):='/usr/bin/ldapsearch -H ldaps://idldap.sdsu.edu -D "CN=sdf-svc-myrf,OU=Service Accounts,OU=SDF,OU=AX,OU=Delegated OUs,DC=id,DC=sdsu,DC=edu" -w "PASSWORD HERE" -b "OU=Employees,OU=People,DC=id,DC=sdsu,DC=edu" "(EmployeeNumber=817465552)"'; 

BEGIN
  DBMS_OUTPUT.enable(1000000);
  DBMS_JAVA.set_output(1000000);

  SDSUFOWN01.host_command(l_string);

  DBMS_OUTPUT.get_lines(l_output, l_lines);

  FOR i IN 1 .. l_lines LOOP
        DBMS_OUTPUT.put_line(l_output(i));
  END LOOP;
END;
/
--********************************************************************************************************************************
--********************************************************************************************************************************


