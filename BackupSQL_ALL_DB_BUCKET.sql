USE [msdb]
GO

/****** Object:  Job [AllDBBackup]    Script Date: 3/7/2017 8:10:34 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 3/7/2017 8:10:34 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AllDBBackup', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'quik', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [db0476]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'db0476', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/db0476/db0476_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''db0476'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [ETIEmployees]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'ETIEmployees', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/ETIEmployees/ETIEmployees_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''ETIEmployees'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [QEBudget]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'QEBudget', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/QEBudget/QEBudget_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''QEBudget'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [QuikCustomer]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'QuikCustomer', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/QuikCustomer/QuikCustomer_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''QuikCustomer'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [QuikEnterprise]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'QuikEnterprise', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/QuikEnterprise/QuikEnterprise_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''QuikEnterprise'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [QuikEnterprise_Archive]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'QuikEnterprise_Archive', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/QuikEnterprise_Archive/QuikEnterprise_Archive_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''QuikEnterprise_Archive'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [QuikEnterprise_WebPageLog]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'QuikEnterprise_WebPageLog', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/QuikEnterprise_WebPageLog/QukEnterprise_WebPageLog_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''QuikEnterprise_WebPageLog'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [QuikFieldDefinition]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'QuikFieldDefinition', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/QuikFieldDefinition/QuikFieldDefinition_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''QuikFieldDefinition'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [QuikFormsManager]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'QuikFormsManager', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/QuikFormsManager/QuikFormsManager_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''QuikFormsManager'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [QWFE_Tables]    Script Date: 3/7/2017 8:10:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'QWFE_Tables', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @fileName varchar(100)
SET    @fileName = ''arn:aws:s3:::prod-backup-db/QWFE_Tables/QWFE_Tables_'' +
       + CONVERT(VARCHAR, GETDATE(), 112) + ''_'' +
         CAST(DATEPART(HOUR, GETDATE()) AS VARCHAR) + ''_'' +
         CAST(DATEPART(MINUTE,GETDATE()) AS VARCHAR) + ''.bak''
exec msdb.dbo.rds_backup_database 
        @source_db_name=''QWFE_Tables'', 
        @s3_arn_to_backup_to=@fileName,
        @overwrite_S3_backup_file=0;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 6 hours Daily Backup', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=6, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20170307, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'c1b4cb64-6280-4152-be45-c1d501d49491'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


