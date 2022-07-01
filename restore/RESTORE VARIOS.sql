USE MASTER 
GO

--VALIDAR VERSION 
--restore HEADERONLY  FROM DISK = '\\boinfsqln3\backups\Firmas_20160809.bak'
--VALIDAR NOMBRES LOGICOS
--restore FILELISTONLY  FROM DISK = 'F:\BACKUP\tm61channel_20161011.BAK' 
--restore FILELISTONLY  FROM DISK = 'F:\BACKUP\tm61contact_20161011.BAK' 
--restore FILELISTONLY  FROM DISK = 'F:\BACKUP\tm61tjtot_20161011.BAK' 
--restore FILELISTONLY  FROM DISK = 'F:\BACKUP\tm61attrs_20161011.BAK' 
--restore FILELISTONLY  FROM DISK = 'F:\BACKUP\NavDB_20161011.BAK'
--restore FILELISTONLY  FROM DISK = 'F:\BACKUP\tm61txserver_20161011.BAK'
--restore FILELISTONLY  FROM DISK = 'F:\BACKUP\tm61txserverlb_20161011.BAK'
--restore FILELISTONLY  FROM DISK = 'F:\BACKUP\tm61wap_20161011.BAK'

--RESTORE
restore database tm61channel  FROM DISK = 'F:\BACKUP\tm61channel_20161011.BAK' 
WITH
MOVE 'tmchannel_Data' TO 'F:\DATABASES\INT2\DATA\tm61channel.mdf',
--MOVE 'tmtjtot_Hist_Data01' TO 'F:\DATABASES\DATA\tm61tjtot_Hist_Data01.ndf',
MOVE 'tmchannel_Log' TO 'F:\DATABASES\INT2\log\tm61channel_1.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10



restore database tm61contact  FROM DISK = 'F:\BACKUP\tm61contact_20161011.BAK' 
WITH
MOVE 'tmcontact_Data' TO 'F:\DATABASES\INT2\DATA\tm61contact_Data.mdf',
--MOVE 'tmtjtot_Hist_Data01' TO 'F:\DATABASES\DATA\tm61tjtot_Hist_Data01.ndf',
MOVE 'tmcontact_Log' TO 'F:\DATABASES\INT2\log\tm61contact_Log.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10


--3
restore database tm61tjtot  FROM DISK = 'F:\BACKUP\tm61tjtot_20161011.BAK' 
WITH
MOVE 'tmtjtot_Data' TO 'F:\DATABASES\INT2\DATA\tm61tjtot_Data.mdf',
--MOVE 'tmtjtot_Hist_Data01' TO 'F:\DATABASES\DATA\tm61tjtot_Hist_Data01.ndf',
MOVE 'tmtjtot_Log' TO 'F:\DATABASES\INT2\log\tm61tjtot_Log.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10


--4 tm61attrs

restore database tm61attrs  FROM DISK = 'F:\BACKUP\tm61attrs_20161011.BAK' 
WITH
MOVE 'tmattrs_Data' TO 'F:\DATABASES\INT2\DATA\tm61attrs_Data.mdf',
--MOVE 'tmtjtot_Hist_Data01' TO 'F:\DATABASES\DATA\tm61tjtot_Hist_Data01.ndf',
MOVE 'tmattrs_Log' TO 'F:\DATABASES\INT2\log\tm61attrs_Log.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10


--5 'F:\BACKUP\NavDB_20161011.BAK'

restore database NavDB  FROM DISK = 'F:\BACKUP\NavDB_20161011.BAK'
WITH
MOVE 'NavDB' TO 'F:\DATABASES\INT2\DATA\NavDB_Data.mdf',
--MOVE 'tmtjtot_Hist_Data01' TO 'F:\DATABASES\DATA\tm61tjtot_Hist_Data01.ndf',
MOVE 'NavDB_log' TO 'F:\DATABASES\INT2\log\NavDB_Log.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10


--6 'F:\BACKUP\tm61txserver_20161011.BAK'

restore database tm61txserver  FROM DISK = 'F:\BACKUP\tm61txserver_20161011.BAK'
WITH
MOVE 'tmtxserver_Data' TO 'F:\DATABASES\INT2\DATA\tm61txserver_Data.mdf',
--MOVE 'tmtjtot_Hist_Data01' TO 'F:\DATABASES\DATA\tm61tjtot_Hist_Data01.ndf',
MOVE 'tmtxserver_Log' TO 'F:\DATABASES\INT2\log\tm61txserver_Log.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10

--7 'F:\BACKUP\tm61txserverlb_20161011.BAK'

restore database tm61txserverlb FROM DISK = 'F:\BACKUP\tm61txserverlb_20161011.BAK'
WITH
MOVE 'tmtxserverlb_Data' TO 'F:\DATABASES\INT2\tm61txserverlb_Data.mdf',
--MOVE 'tmtjtot_Hist_Data01' TO 'F:\DATABASES\DATA\tm61tjtot_Hist_Data01.ndf',
MOVE 'tmtxserverlb_Log' TO 'F:\DATABASES\INT2\log\tm61txserverlb_Log.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10


--8 'F:\BACKUP\tm61wap_20161011.BAK'


restore database tm61wap FROM DISK = 'F:\BACKUP\tm61wap_20161011.BAK'
WITH
MOVE 'tmwap_Data' TO 'F:\DATABASES\INT2\tm61wap_Data.mdf',
--MOVE 'tmtjtot_Hist_Data01' TO 'F:\DATABASES\DATA\tm61tjtot_Hist_Data01.ndf',
MOVE 'tmwap_Log' TO 'F:\DATABASES\INT2\log\tm61wap_Log.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10
