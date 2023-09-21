

Create partition function fnPartitionAttLogTime(datetime)
AS range left
for values ('20171231','20181231','20191231','20201231')

GO

Create partition scheme scmPartitionAttLogTime
As Partition fnPartitionAttLogTime
TO (Attendance2017,Attendance2018,Attendance2019,Attendance2020)