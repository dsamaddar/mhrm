

Create proc spInsertDesignation
@DesignationName nvarchar(200),
@DesignationLabel nvarchar(100),
@DesignationType nvarchar(50),
@HealthPlanID nvarchar(50),
@intOrder integer,
@EvaluationGroupID nvarchar(50),
@Fuel int,
@DriverAllowance numeric(18,2),
@VehicleMaintenance numeric(18,2),
@CarSubsidy  numeric(18,2),
@NoticePeriod int,
@MobileAllowance numeric(18,2),
@TransportAllowance numeric(18,2),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

	if @EvaluationGroupID = 'N\A'
		Set @EvaluationGroupID = null

	Declare @DesignationID nvarchar(50)
	Declare @CurrentDesignationID numeric(18,0)
	Declare @DesignationIDPrefix as nvarchar(6)

	set @DesignationIDPrefix='DESIG-'

begin tran
	
	select @CurrentDesignationID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentDesignationID'
	
	set @CurrentDesignationID=isnull(@CurrentDesignationID,0)+1
	Select @DesignationID=dbo.generateID(@DesignationIDPrefix,@CurrentDesignationID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblDesignation(DesignationID,DesignationName,DesignationLabel,DesignationType,HealthPlanID,intOrder,EvaluationGroupID,
	Fuel,DriverAllowance,VehicleMaintenance,CarSubsidy,NoticePeriod,MobileAllowance,TransportAllowance,IsActive,EntryBy)
	Values(@DesignationID,@DesignationName,@DesignationLabel,@DesignationType,@HealthPlanID,@intOrder,@EvaluationGroupID ,
	@Fuel,@DriverAllowance,@VehicleMaintenance,@CarSubsidy,@NoticePeriod,@MobileAllowance,@TransportAllowance,@IsActive,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentDesignationID where PropertyName='CurrentDesignationID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO


Create Proc spUpdateDesignation
@DesignationID nvarchar(50),
@DesignationName nvarchar(50),
@DesignationLabel nvarchar(100),
@DesignationType nvarchar(50),
@HealthPlanID nvarchar(50),
@intOrder int,
@EvaluationGroupID nvarchar(50),
@Fuel int,
@DriverAllowance numeric(18,2),
@VehicleMaintenance numeric(18,2),
@CarSubsidy  numeric(18,2),
@NoticePeriod int,
@MobileAllowance numeric(18,2),
@TransportAllowance numeric(18,2),
@IsActive bit
as
begin
	
	if @EvaluationGroupID = 'N\A'
		Set @EvaluationGroupID = null

	UPDATE tblDesignation SET DesignationName = @DesignationName,DesignationLabel = @DesignationLabel,DesignationType = @DesignationType,
	HealthPlanID =@HealthPlanID,intOrder = @intOrder,EvaluationGroupID = @EvaluationGroupID,Fuel=@Fuel,DriverAllowance=@DriverAllowance,
	VehicleMaintenance=@VehicleMaintenance,CarSubsidy=@CarSubsidy,NoticePeriod=@NoticePeriod,MobileAllowance=@MobileAllowance,TransportAllowance=@TransportAllowance,isActive = @IsActive
	WHERE DesignationID=@DesignationID

end

GO


Create proc spGetDesignation
as
begin
	select DesignationID,DesignationName,DesignationLabel,DesignationType,intOrder, HealthPlanID 
	,(select HealthPlanName  from tblHealthPlan where HealthPlanID =tblDesignation.HealthPlanID ) HealthPlanName
	,isnull(EvaluationGroupID,'N\A') as 'EvaluationGroupID'
	,isnull((Select EvaluationGroup from tblEvaluationGroup EG Where EG.EvaluationGroupID = tblDesignation.EvaluationGroupID),'N\A')  as 'EvaluationGroup'
	,Isnull(Fuel,0) as 'Fuel',Isnull(DriverAllowance,0) as 'DriverAllowance',Isnull(VehicleMaintenance,0) as 'VehicleMaintenance',
	Isnull(CarSubsidy,0) as 'CarSubsidy',Isnull(NoticePeriod,0) as 'NoticePeriod' ,case when isActive ='True' then 'Active' else 'InActive' end as isActive,
	ISNULL(MobileAllowance,0) as 'MobileAllowance',ISNULL(TransportAllowance,0) as 'TransportAllowance'
	from dbo.tblDesignation  where DesignationName<>'' order by DesignationType,intOrder
end
