Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.Services

Public Class clsEmployeeInfo

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _EmployeeID, _CandidateID, _EmpIDOrName, _EmployeeName, _UserID, _Password, _UserType, _EmpCode, _EmpTypeID, _TerminationTypeID, _RemarksOnTermination, _JoiningDesignationID, _OfficialDesignationID As String
    Dim _FunctionalDesignationID, _DepartmentID, _ULCBranchID, _CurrentSupervisor, _JDno, _EmpStatus, _BankID, _BranchID, _BankAccountNo, _Email As String
    Dim _DateOfBirth, _JoiningDate, _JoiningDateTo, _ProbationEffectiveDate, _ConfirmationDate, _PromotionDate, _ContractExpiryDate, _ContractRenewalDate, _TerminationDate As DateTime
    Dim _LeaveApprover, _LeaveRecommender, _AttendanceID, _EntryBy, _PermittedMenus As String

    Public Property CandidateID() As String
        Get
            Return _CandidateID
        End Get
        Set(ByVal value As String)
            _CandidateID = value
        End Set
    End Property

    Public Property PermittedMenus() As String
        Get
            Return _PermittedMenus
        End Get
        Set(ByVal value As String)
            _PermittedMenus = value
        End Set
    End Property

    Dim _FathersName, _FathersOccupation, _MothersName, _MothersOccupation, _SpouseName, _SpouseOccupation, _NoOfChildrenAge, _
    _SibblingsNameOccupation, _RelationshipStatus, _Gender, _NIDNo, _Nationality, _Religion, _PresentAddress, _
    _PermanentAddress, _MobileNo, _OfficePhone, _OfficeExtension, _AlternateEmail, _Photos, _Signature, _
    _BloodGroupID, _EmmergencyConPerName, _EmmerConPerPhone, _RelWithEmmerConPer, _InsuranceNo, _TinNo, _PassportNo, _
    _DrivingLicenseNo As String

    Public Property FathersName() As String
        Get
            Return _FathersName
        End Get
        Set(ByVal value As String)
            _FathersName = value
        End Set
    End Property

    Public Property FathersOccupation() As String
        Get
            Return _FathersOccupation
        End Get
        Set(ByVal value As String)
            _FathersOccupation = value
        End Set
    End Property

    Public Property MothersName() As String
        Get
            Return _MothersName
        End Get
        Set(ByVal value As String)
            _MothersName = value
        End Set
    End Property

    Public Property MothersOccupation() As String
        Get
            Return _MothersOccupation
        End Get
        Set(ByVal value As String)
            _MothersOccupation = value
        End Set
    End Property

    Public Property SpouseName() As String
        Get
            Return _SpouseName
        End Get
        Set(ByVal value As String)
            _SpouseName = value
        End Set
    End Property

    Public Property SpouseOccupation() As String
        Get
            Return _SpouseOccupation
        End Get
        Set(ByVal value As String)
            _SpouseOccupation = value
        End Set
    End Property

    Public Property NoOfChildrenAge() As String
        Get
            Return _NoOfChildrenAge
        End Get
        Set(ByVal value As String)
            _NoOfChildrenAge = value
        End Set
    End Property

    Public Property SibblingsNameOccupation() As String
        Get
            Return _SibblingsNameOccupation
        End Get
        Set(ByVal value As String)
            _SibblingsNameOccupation = value
        End Set
    End Property

    Public Property RelationshipStatus() As String
        Get
            Return _RelationshipStatus
        End Get
        Set(ByVal value As String)
            _RelationshipStatus = value
        End Set
    End Property

    Public Property Gender() As String
        Get
            Return _Gender
        End Get
        Set(ByVal value As String)
            _Gender = value
        End Set
    End Property

    Public Property NIDNo() As String
        Get
            Return _NIDNo
        End Get
        Set(ByVal value As String)
            _NIDNo = value
        End Set
    End Property

    Public Property Nationality() As String
        Get
            Return _Nationality
        End Get
        Set(ByVal value As String)
            _Nationality = value
        End Set
    End Property

    Public Property Religion() As String
        Get
            Return _Religion
        End Get
        Set(ByVal value As String)
            _Religion = value
        End Set
    End Property

    Public Property PresentAddress() As String
        Get
            Return _PresentAddress
        End Get
        Set(ByVal value As String)
            _PresentAddress = value
        End Set
    End Property

    Public Property PermanentAddress() As String
        Get
            Return _PermanentAddress
        End Get
        Set(ByVal value As String)
            _PermanentAddress = value
        End Set
    End Property

    Public Property MobileNo() As String
        Get
            Return _MobileNo
        End Get
        Set(ByVal value As String)
            _MobileNo = value
        End Set
    End Property

    Public Property OfficePhone() As String
        Get
            Return _OfficePhone
        End Get
        Set(ByVal value As String)
            _OfficePhone = value
        End Set
    End Property

    Public Property OfficeExtension() As String
        Get
            Return _OfficeExtension
        End Get
        Set(ByVal value As String)
            _OfficeExtension = value
        End Set
    End Property

    Public Property AlternateEmail() As String
        Get
            Return _AlternateEmail
        End Get
        Set(ByVal value As String)
            _AlternateEmail = value
        End Set
    End Property

    Public Property Photos() As String
        Get
            Return _Photos
        End Get
        Set(ByVal value As String)
            _Photos = value
        End Set
    End Property

    Public Property Signature() As String
        Get
            Return _Signature
        End Get
        Set(ByVal value As String)
            _Signature = value
        End Set
    End Property

    Public Property BloodGroupID() As String
        Get
            Return _BloodGroupID
        End Get
        Set(ByVal value As String)
            _BloodGroupID = value
        End Set
    End Property

    Public Property EmmergencyConPerName() As String
        Get
            Return _EmmergencyConPerName
        End Get
        Set(ByVal value As String)
            _EmmergencyConPerName = value
        End Set
    End Property

    Public Property EmmerConPerPhone() As String
        Get
            Return _EmmerConPerPhone
        End Get
        Set(ByVal value As String)
            _EmmerConPerPhone = value
        End Set
    End Property

    Public Property RelWithEmmerConPer() As String
        Get
            Return _RelWithEmmerConPer
        End Get
        Set(ByVal value As String)
            _RelWithEmmerConPer = value
        End Set
    End Property

    Public Property InsuranceNo() As String
        Get
            Return _InsuranceNo
        End Get
        Set(ByVal value As String)
            _InsuranceNo = value
        End Set
    End Property

    Public Property TinNo() As String
        Get
            Return _TinNo
        End Get
        Set(ByVal value As String)
            _TinNo = value
        End Set
    End Property

    Public Property PassportNo() As String
        Get
            Return _PassportNo
        End Get
        Set(ByVal value As String)
            _PassportNo = value
        End Set
    End Property

    Public Property DrivingLicenseNo() As String
        Get
            Return _DrivingLicenseNo
        End Get
        Set(ByVal value As String)
            _DrivingLicenseNo = value
        End Set
    End Property

    Dim _PreDistrict, _PreThana, _PerDistrict, _PerThana, _ActualBirthDay, _ActualBirthMonth As Integer

    Public Property PreDistrict() As Integer
        Get
            Return _PreDistrict
        End Get
        Set(ByVal value As Integer)
            _PreDistrict = value
        End Set
    End Property

    Public Property PreThana() As Integer
        Get
            Return _PreThana
        End Get
        Set(ByVal value As Integer)
            _PreThana = value
        End Set
    End Property

    Public Property PerDistrict() As Integer
        Get
            Return _PerDistrict
        End Get
        Set(ByVal value As Integer)
            _PerDistrict = value
        End Set
    End Property

    Public Property PerThana() As Integer
        Get
            Return _PerThana
        End Get
        Set(ByVal value As Integer)
            _PerThana = value
        End Set
    End Property

    Public Property ActualBirthDay() As Integer
        Get
            Return _ActualBirthDay
        End Get
        Set(ByVal value As Integer)
            _ActualBirthDay = value
        End Set
    End Property

    Public Property ActualBirthMonth() As Integer
        Get
            Return _ActualBirthMonth
        End Get
        Set(ByVal value As Integer)
            _ActualBirthMonth = value
        End Set
    End Property

    Dim _ApproverID, _RecommenderID, _PrimaryEvaluator, _SecondaryEvaluator, _OfficialDesignation, _FunctionalDesignation, _HealthPlanID As String

    Public Property ApproverID() As String
        Get
            Return _ApproverID
        End Get
        Set(ByVal value As String)
            _ApproverID = value
        End Set
    End Property

    Public Property RecommenderID() As String
        Get
            Return _RecommenderID
        End Get
        Set(ByVal value As String)
            _RecommenderID = value
        End Set
    End Property

    Public Property PrimaryEvaluator() As String
        Get
            Return _PrimaryEvaluator
        End Get
        Set(ByVal value As String)
            _PrimaryEvaluator = value
        End Set
    End Property

    Public Property SecondaryEvaluator() As String
        Get
            Return _SecondaryEvaluator
        End Get
        Set(ByVal value As String)
            _SecondaryEvaluator = value
        End Set
    End Property

    Public Property OfficialDesignation() As String
        Get
            Return _OfficialDesignation
        End Get
        Set(ByVal value As String)
            _OfficialDesignation = value
        End Set
    End Property

    Public Property FunctionalDesignation() As String
        Get
            Return _FunctionalDesignation
        End Get
        Set(ByVal value As String)
            _FunctionalDesignation = value
        End Set
    End Property

    Public Property HealthPlanID() As String
        Get
            Return _HealthPlanID
        End Get
        Set(ByVal value As String)
            _HealthPlanID = value
        End Set
    End Property

    Dim _SecondaryBankID, _SecondaryBranchID, _SecondaryBankAccountNo As String
    Dim _Fuel, _DriverAllowance, _VehicleMaintenance, _CarSubsidy As Double
    Dim _ProbationPeriod As Integer

    Public Property SecondaryBankID() As String
        Get
            Return _SecondaryBankID
        End Get
        Set(ByVal value As String)
            _SecondaryBankID = value
        End Set
    End Property

    Public Property SecondaryBranchID() As String
        Get
            Return _SecondaryBranchID
        End Get
        Set(ByVal value As String)
            _SecondaryBranchID = value
        End Set
    End Property

    Public Property SecondaryBankAccountNo() As String
        Get
            Return _SecondaryBankAccountNo
        End Get
        Set(ByVal value As String)
            _SecondaryBankAccountNo = value
        End Set
    End Property

    Public Property Fuel() As Double
        Get
            Return _Fuel
        End Get
        Set(ByVal value As Double)
            _Fuel = value
        End Set
    End Property

    Public Property DriverAllowance() As Double
        Get
            Return _DriverAllowance
        End Get
        Set(ByVal value As Double)
            _DriverAllowance = value
        End Set
    End Property

    Public Property VehicleMaintenance() As Double
        Get
            Return _VehicleMaintenance
        End Get
        Set(ByVal value As Double)
            _VehicleMaintenance = value
        End Set
    End Property

    Public Property CarSubsidy() As Double
        Get
            Return _CarSubsidy
        End Get
        Set(ByVal value As Double)
            _CarSubsidy = value
        End Set
    End Property

    Public Property EmployeeID() As String
        Get
            Return _EmployeeID
        End Get
        Set(ByVal value As String)
            _EmployeeID = value
        End Set
    End Property

    Public Property EmpIDOrName() As String
        Get
            Return _EmpIDOrName
        End Get
        Set(ByVal value As String)
            _EmpIDOrName = value
        End Set
    End Property

    Public Property Email() As String
        Get
            Return _Email
        End Get
        Set(ByVal value As String)
            _Email = value
        End Set
    End Property

    Public Property LeaveApprover() As String
        Get
            Return _LeaveApprover
        End Get
        Set(ByVal value As String)
            _LeaveApprover = value
        End Set
    End Property

    Public Property LeaveRecommender() As String
        Get
            Return _LeaveRecommender
        End Get
        Set(ByVal value As String)
            _LeaveRecommender = value
        End Set
    End Property

    Dim _isActive, _IsEligibleForExternalTA, _AutoAdvTaxDeduction, _IsPermittedToShowOwn, _IsPermittedToShowOthers, _IncludedInPayroll As Boolean

    Public Property isActive() As Boolean
        Get
            Return _isActive
        End Get
        Set(ByVal value As Boolean)
            _isActive = value
        End Set
    End Property

    Public Property IsEligibleForExternalTA() As Boolean
        Get
            Return _IsEligibleForExternalTA
        End Get
        Set(ByVal value As Boolean)
            _IsEligibleForExternalTA = value
        End Set
    End Property

    Public Property AutoAdvTaxDeduction() As Boolean
        Get
            Return _AutoAdvTaxDeduction
        End Get
        Set(ByVal value As Boolean)
            _AutoAdvTaxDeduction = value
        End Set
    End Property

    Public Property IsPermittedToShowOwn() As Boolean
        Get
            Return _IsPermittedToShowOwn
        End Get
        Set(ByVal value As Boolean)
            _IsPermittedToShowOwn = value
        End Set
    End Property

    Public Property IsPermittedToShowOthers() As Boolean
        Get
            Return _IsPermittedToShowOthers
        End Get
        Set(ByVal value As Boolean)
            _IsPermittedToShowOthers = value
        End Set
    End Property

    Public Property IncludedInPayroll() As Boolean
        Get
            Return _IncludedInPayroll
        End Get
        Set(ByVal value As Boolean)
            _IncludedInPayroll = value
        End Set
    End Property

    Public Property UserID() As String
        Get
            Return _UserID
        End Get
        Set(ByVal value As String)
            _UserID = value
        End Set
    End Property

    Public Property Password() As String
        Get
            Return _Password
        End Get
        Set(ByVal value As String)
            _Password = value
        End Set
    End Property

    Public Property UserType() As String
        Get
            Return _UserType
        End Get
        Set(ByVal value As String)
            _UserType = value
        End Set
    End Property

    Public Property EmployeeName() As String
        Get
            Return _EmployeeName
        End Get
        Set(ByVal value As String)
            _EmployeeName = value
        End Set
    End Property

    Public Property EmpCode() As String
        Get
            Return _EmpCode
        End Get
        Set(ByVal value As String)
            _EmpCode = value
        End Set
    End Property

    Public Property EmpTypeID() As String
        Get
            Return _EmpTypeID
        End Get
        Set(ByVal value As String)
            _EmpTypeID = value
        End Set
    End Property

    Public Property TerminationTypeID() As String
        Get
            Return _TerminationTypeID
        End Get
        Set(ByVal value As String)
            _TerminationTypeID = value
        End Set
    End Property

    Public Property RemarksOnTermination() As String
        Get
            Return _RemarksOnTermination
        End Get
        Set(ByVal value As String)
            _RemarksOnTermination = value
        End Set
    End Property

    Public Property JoiningDesignationID() As String
        Get
            Return _JoiningDesignationID
        End Get
        Set(ByVal value As String)
            _JoiningDesignationID = value
        End Set
    End Property

    Public Property OfficialDesignationID() As String
        Get
            Return _OfficialDesignationID
        End Get
        Set(ByVal value As String)
            _OfficialDesignationID = value
        End Set
    End Property

    Public Property FunctionalDesignationID() As String
        Get
            Return _FunctionalDesignationID
        End Get
        Set(ByVal value As String)
            _FunctionalDesignationID = value
        End Set
    End Property

    Public Property DepartmentID() As String
        Get
            Return _DepartmentID
        End Get
        Set(ByVal value As String)
            _DepartmentID = value
        End Set
    End Property

    Public Property ULCBranchID() As String
        Get
            Return _ULCBranchID
        End Get
        Set(ByVal value As String)
            _ULCBranchID = value
        End Set
    End Property

    Public Property CurrentSupervisor() As String
        Get
            Return _CurrentSupervisor
        End Get
        Set(ByVal value As String)
            _CurrentSupervisor = value
        End Set
    End Property

    Public Property JDno() As String
        Get
            Return _JDno
        End Get
        Set(ByVal value As String)
            _JDno = value
        End Set
    End Property

    Public Property Status() As String
        Get
            Return _EmpStatus
        End Get
        Set(ByVal value As String)
            _EmpStatus = value
        End Set
    End Property

    Public Property BankID() As String
        Get
            Return _BankID
        End Get
        Set(ByVal value As String)
            _BankID = value
        End Set
    End Property

    Public Property BranchID() As String
        Get
            Return _BranchID
        End Get
        Set(ByVal value As String)
            _BranchID = value
        End Set
    End Property

    Public Property BankAccountNo() As String
        Get
            Return _BankAccountNo
        End Get
        Set(ByVal value As String)
            _BankAccountNo = value
        End Set
    End Property

    Public Property AttendanceID() As String
        Get
            Return _AttendanceID
        End Get
        Set(ByVal value As String)
            _AttendanceID = value
        End Set
    End Property

    Public Property DateOfBirth() As DateTime
        Get
            Return _DateOfBirth
        End Get
        Set(ByVal value As DateTime)
            _DateOfBirth = value
        End Set
    End Property

    Public Property JoiningDate() As DateTime
        Get
            Return _JoiningDate
        End Get
        Set(ByVal value As DateTime)
            _JoiningDate = value
        End Set
    End Property

    Public Property JoiningDateTo() As DateTime
        Get
            Return _JoiningDateTo
        End Get
        Set(ByVal value As DateTime)
            _JoiningDateTo = value
        End Set
    End Property

    Public Property ProbationEffectiveDate() As DateTime
        Get
            Return _ProbationEffectiveDate
        End Get
        Set(ByVal value As DateTime)
            _ProbationEffectiveDate = value
        End Set
    End Property

    Public Property ConfirmationDate() As DateTime
        Get
            Return _ConfirmationDate
        End Get
        Set(ByVal value As DateTime)
            _ConfirmationDate = value
        End Set
    End Property

    Public Property PromotionDate() As DateTime
        Get
            Return _PromotionDate
        End Get
        Set(ByVal value As DateTime)
            _PromotionDate = value
        End Set
    End Property

    Public Property ContractExpiryDate() As DateTime
        Get
            Return _ContractExpiryDate
        End Get
        Set(ByVal value As DateTime)
            _ContractExpiryDate = value
        End Set
    End Property

    Public Property ContractRenewalDate() As DateTime
        Get
            Return _ContractRenewalDate
        End Get
        Set(ByVal value As DateTime)
            _ContractRenewalDate = value
        End Set
    End Property

    Public Property TerminationDate() As DateTime
        Get
            Return _TerminationDate
        End Get
        Set(ByVal value As DateTime)
            _TerminationDate = value
        End Set
    End Property

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Dim _BasicSalary, _EntryExamScore, _PromotionalExamScore As Double

    Public Property BasicSalary() As Double
        Get
            Return _BasicSalary
        End Get
        Set(ByVal value As Double)
            _BasicSalary = value
        End Set
    End Property

    Public Property EntryExamScore() As Double
        Get
            Return _EntryExamScore
        End Get
        Set(ByVal value As Double)
            _EntryExamScore = value
        End Set
    End Property

    Public Property PromotionalExamScore() As Double
        Get
            Return _PromotionalExamScore
        End Get
        Set(ByVal value As Double)
            _PromotionalExamScore = value
        End Set
    End Property

    Public Property ProbationPeriod() As Integer
        Get
            Return _ProbationPeriod
        End Get
        Set(ByVal value As Integer)
            _ProbationPeriod = value
        End Set
    End Property

    Dim _Department, _EmpType, _EmpTypeNm, _ServiceLength, _Branch As String

    Public Property Department() As String
        Get
            Return _Department
        End Get
        Set(ByVal value As String)
            _Department = value
        End Set
    End Property

    Public Property EmpType() As String
        Get
            Return _EmpType
        End Get
        Set(ByVal value As String)
            _EmpType = value
        End Set
    End Property

    Public Property EmpTypeNm() As String
        Get
            Return _EmpTypeNm
        End Get
        Set(ByVal value As String)
            _EmpTypeNm = value
        End Set
    End Property

    Public Property ServiceLength() As String
        Get
            Return _ServiceLength
        End Get
        Set(ByVal value As String)
            _ServiceLength = value
        End Set
    End Property

    Public Property Branch() As String
        Get
            Return _Branch
        End Get
        Set(ByVal value As String)
            _Branch = value
        End Set
    End Property

    '' ***************************************
#Region " Check User Login "

    Public Function fnCheckUserLogin(ByVal EmpInfo As clsEmployeeInfo) As clsEmployeeInfo
        Dim sp As String = "spCheckUserLogin"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmpCode", EmpInfo.EmpCode)
                cmd.Parameters.AddWithValue("@UserPassword", EmpInfo.Password)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmpInfo.EmployeeID = dr.Item("EmployeeID")
                    EmpInfo.UserID = dr.Item("UserID")
                    EmpInfo.UserType = dr.Item("UserType")
                    EmpInfo.EmployeeName = dr.Item("EmployeeName")
                    EmpInfo.ULCBranchID = dr.Item("ULCBranchID")
                    EmpInfo.PermittedMenus = dr.Item("PermittedMenus")
                End While
                con.Close()
                Return EmpInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

    '' ***************************************

#Region " Add New Employee "
    Public Function fnAddNewEmployee(ByVal EmployeeInfo As clsEmployeeInfo) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spAddNewEmployee", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeName", EmployeeInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@EmpCode", EmployeeInfo.EmpCode)
            cmd.Parameters.AddWithValue("@UserID", EmployeeInfo.UserID)
            cmd.Parameters.AddWithValue("@Password", EmployeeInfo.Password)
            cmd.Parameters.AddWithValue("@EntryBy", EmployeeInfo.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Insert Employee Info "
    Public Function fnInsertEmpInfo(ByVal EmployeeInfo As clsEmployeeInfo, ByVal EntryBy As String) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertEmployeeInformation", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeName", EmployeeInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@EmpCode", EmployeeInfo.EmpCode)
            cmd.Parameters.AddWithValue("@UserID", EmployeeInfo.UserID)
            cmd.Parameters.AddWithValue("@Password", EmployeeInfo.Password)
            cmd.Parameters.AddWithValue("@EmpTypeID", EmployeeInfo.EmpTypeID)
            cmd.Parameters.AddWithValue("@TerminationTypeID", EmployeeInfo.TerminationTypeID)
            cmd.Parameters.AddWithValue("@RemarksOnTermination", EmployeeInfo.RemarksOnTermination)
            cmd.Parameters.AddWithValue("@JoiningDesignationID", EmployeeInfo.JoiningDesignationID)
            cmd.Parameters.AddWithValue("@OfficialDesignationID", EmployeeInfo.OfficialDesignationID)
            cmd.Parameters.AddWithValue("@FunctionalDesignationID", EmployeeInfo.FunctionalDesignationID)
            cmd.Parameters.AddWithValue("@DepartmentID", EmployeeInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@ULCBranchID", EmployeeInfo.ULCBranchID)
            cmd.Parameters.AddWithValue("@CurrentSupervisor", EmployeeInfo.CurrentSupervisor)
            cmd.Parameters.AddWithValue("@JDno", EmployeeInfo.JDno)
            cmd.Parameters.AddWithValue("@Status", EmployeeInfo.Status)
            cmd.Parameters.AddWithValue("@BankID", EmployeeInfo.BankID)
            cmd.Parameters.AddWithValue("@BranchID", EmployeeInfo.BranchID)
            cmd.Parameters.AddWithValue("@BankAccountNo", EmployeeInfo.BankAccountNo)
            cmd.Parameters.AddWithValue("@Email", EmployeeInfo.Email)
            cmd.Parameters.AddWithValue("@DateOfBirth", EmployeeInfo.DateOfBirth)
            cmd.Parameters.AddWithValue("@JoiningDate", EmployeeInfo.JoiningDate)
            cmd.Parameters.AddWithValue("@ConfirmationDate", EmployeeInfo.ConfirmationDate)
            cmd.Parameters.AddWithValue("@PromotionDate", EmployeeInfo.PromotionDate)
            cmd.Parameters.AddWithValue("@ContractExpiryDate", EmployeeInfo.ContractExpiryDate)
            cmd.Parameters.AddWithValue("@ContractRenewalDate", EmployeeInfo.ContractRenewalDate)
            cmd.Parameters.AddWithValue("@TerminationDate", EmployeeInfo.TerminationDate)
            cmd.Parameters.AddWithValue("@EntryExamScore", EmployeeInfo.EntryExamScore)
            cmd.Parameters.AddWithValue("@PromotionalExamScore", EmployeeInfo.PromotionalExamScore)
            cmd.Parameters.AddWithValue("@isActive", EmployeeInfo.isActive)
            cmd.Parameters.AddWithValue("@UserType", EmployeeInfo.UserType)
            cmd.Parameters.AddWithValue("@LeaveApprover", EmployeeInfo.LeaveApprover)
            cmd.Parameters.AddWithValue("@LeaveRecommender", EmployeeInfo.LeaveRecommender)
            cmd.Parameters.AddWithValue("@EntryBy", EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Update Employee Info "
    Public Function fnUpdateEmpInfo(ByVal EmployeeInfo As clsEmployeeInfo, ByVal EmployeeID As String) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateEmployeeInformation", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
            cmd.Parameters.AddWithValue("@UserID", EmployeeInfo.UserID)
            cmd.Parameters.AddWithValue("@Password", EmployeeInfo.Password)
            cmd.Parameters.AddWithValue("@UserType", EmployeeInfo.UserType)
            cmd.Parameters.AddWithValue("@EmployeeName", EmployeeInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@EmpCode", EmployeeInfo.EmpCode)
            cmd.Parameters.AddWithValue("@EmpTypeID", EmployeeInfo.EmpTypeID)
            cmd.Parameters.AddWithValue("@TerminationTypeID", EmployeeInfo.TerminationTypeID)
            cmd.Parameters.AddWithValue("@RemarksOnTermination", EmployeeInfo.RemarksOnTermination)
            cmd.Parameters.AddWithValue("@JoiningDesignationID", EmployeeInfo.JoiningDesignationID)
            cmd.Parameters.AddWithValue("@OfficialDesignationID", EmployeeInfo.OfficialDesignationID)
            cmd.Parameters.AddWithValue("@FunctionalDesignationID", EmployeeInfo.FunctionalDesignationID)
            cmd.Parameters.AddWithValue("@DepartmentID", EmployeeInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@ULCBranchID", EmployeeInfo.ULCBranchID)
            cmd.Parameters.AddWithValue("@CurrentSupervisor", EmployeeInfo.CurrentSupervisor)
            cmd.Parameters.AddWithValue("@JDno", EmployeeInfo.JDno)
            cmd.Parameters.AddWithValue("@Status", EmployeeInfo.Status)
            cmd.Parameters.AddWithValue("@BankID", EmployeeInfo.BankID)
            cmd.Parameters.AddWithValue("@BranchID", EmployeeInfo.BranchID)
            cmd.Parameters.AddWithValue("@BankAccountNo", EmployeeInfo.BankAccountNo)
            cmd.Parameters.AddWithValue("@Email", EmployeeInfo.Email)
            cmd.Parameters.AddWithValue("@DateOfBirth", EmployeeInfo.DateOfBirth)
            cmd.Parameters.AddWithValue("@JoiningDate", EmployeeInfo.JoiningDate)
            cmd.Parameters.AddWithValue("@ConfirmationDate", EmployeeInfo.ConfirmationDate)
            cmd.Parameters.AddWithValue("@PromotionDate", EmployeeInfo.PromotionDate)
            cmd.Parameters.AddWithValue("@ContractExpiryDate", EmployeeInfo.ContractExpiryDate)
            cmd.Parameters.AddWithValue("@ContractRenewalDate", EmployeeInfo.ContractRenewalDate)
            cmd.Parameters.AddWithValue("@TerminationDate", EmployeeInfo.TerminationDate)
            cmd.Parameters.AddWithValue("@EntryExamScore", EmployeeInfo.EntryExamScore)
            cmd.Parameters.AddWithValue("@PromotionalExamScore", EmployeeInfo.PromotionalExamScore)
            cmd.Parameters.AddWithValue("@isActive", EmployeeInfo.isActive)
            cmd.Parameters.AddWithValue("@LeaveApprover", EmployeeInfo.LeaveApprover)
            cmd.Parameters.AddWithValue("@LeaveRecommender", EmployeeInfo.LeaveRecommender)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Emp. Change Password "
    Public Function fnChangeEmpPassword(ByVal EmployeeID As String, ByVal Password As String) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spChangeEmpPassword", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
            cmd.Parameters.AddWithValue("@Password", Password)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Check Prev Password "
    Public Function fnCheckPrevPassword(ByVal EmployeeID As String, ByVal Password As String) As Integer
        Dim Count As Integer = 0
        Try
            Dim dr As SqlDataReader

            Dim cmd As SqlCommand = New SqlCommand("spCheckPrevPassword", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
            cmd.Parameters.AddWithValue("@Password", Password)
            dr = cmd.ExecuteReader()
            While dr.Read()
                Count = dr.Item("Count")
            End While
            con.Close()
            Return Count
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Count
        End Try
    End Function
#End Region

#Region " Get Employee Information "

    Public Function fnGetEmployeeInformation(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmployeeInformation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Disparity Calculation "

    Public Function fnDisparityCalculation(ByVal EmpInfo As clsEmployeeInfo) As DataSet

        Dim sp As String = "spDisparityCalculation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DesignationID", EmpInfo.OfficialDesignationID)
                cmd.Parameters.AddWithValue("@DepartmentID", EmpInfo.DepartmentID)
                cmd.Parameters.AddWithValue("@ULCBranchID", EmpInfo.ULCBranchID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Employee Type "

    Public Function fnGetEmployeeType() As DataSet

        Dim sp As String = "spGetEmployeeType"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Employee Type By EmpID "

    Public Function fnGetEmployeeTypeByEmpID(ByVal EmployeeID As String) As String

        Dim sp As String = "spGetEmployeeTypeByEmpID"
        Dim dr As SqlDataReader
        Dim EmpTypeNm As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmpTypeNm = dr.Item("EmpTypeNm")
                End While
            End Using
            con.Close()
            Return EmpTypeNm
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Termination Type "

    Public Function fnGetTerminationType() As DataSet

        Dim sp As String = "spGetTerminationType"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get functional Designation Type "

    Public Function fnGetFunctionalDesignation() As DataSet

        Dim sp As String = "spGetFunctionalDesignation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get ULC Branch "

    Public Function fnGetULCBranch() As DataSet

        Dim sp As String = "spGetULCBranch"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Search Emp By Type Code "

    Public Function fnSearchEmpByTypeCode(ByVal EmpTypeCode As String, ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spSearchEmpByTypeCode"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmpTypeCode", EmpTypeCode)
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " List All Active Emp Att Settings "

    Public Function fnListAllActiveEmpAttSettings() As DataSet

        Dim sp As String = "spListAllActiveEmpAttSettings"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Employee List "

    Public Function fnGetEmployeeList() As DataSet

        Dim sp As String = "spGetEmployeeList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Emp List Payroll Active "

    Public Function fnGetEmpListPayrollActive() As DataSet

        Dim sp As String = "spGetEmpListPayrollActive"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Emp List By Type Payroll Active "

    Public Function fnGetEmpListByTypePayrollActive(ByVal EmployeeTypeID As String) As DataSet

        Dim sp As String = "spGetEmpListByTypePayrollActive"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeTypeID", EmployeeTypeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Team Members "

    Public Function fnGetTeamMembers(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetTeamMembers"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Employee List All For Tax Cert "

    Public Function fnGetEmployeeListAllForTaxCert() As DataSet

        Dim sp As String = "spGetEmployeeListAllForTaxCert"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Emp List By Dept "

    Public Function fnGetEmpListByDept(ByVal DepartmentID As String) As DataSet
        Dim sp As String = "spGetEmpListByDept"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DepartmentID", DepartmentID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get SubOrdinate List "

    Public Function fnGetSubOrdinateList(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetSubOrdinateList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Bank Name "

    Public Function fnGetBankName() As DataSet

        Dim sp As String = "spGetBankName"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Branch Name "

    Public Function fnGetBranchName(ByVal BankID As String) As DataSet

        Dim sp As String = "spGetBranchName"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@BankID", BankID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Confirmation Due "

    Public Function fnGetConfirmationDue() As DataSet

        Dim sp As String = "spGetConfirmationDue"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Contract Renewal Due List "

    Public Function fnGetContractRenewalDue() As DataSet

        Dim sp As String = "spGetContractRenewalDue"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Employee Details "

    Public Function fnGetEmployeeDetailInfo() As DataSet

        Dim sp As String = "spGetEmployeeInfo"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Emp Info List Active "

    Public Function fnGetEmpInfoListActive() As DataSet

        Dim sp As String = "spGetEmpInfoListActive"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Resigned Emp List "

    Public Function fnGetResignedEmpList() As DataSet

        Dim sp As String = "spGetResignedEmpList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Emp Transition History By Emp ID "

    Public Function fnGetEmpTranHistoryByEmpID(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmpTranHistoryByEmpID"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Emp Transition New "

    Public Function fnGetEmpTransitionNew(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmpTransitionNew"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Delete Emp Transition "

    Public Function fnDeleteEmpTransition(ByVal TransitionHistoryID As String) As Integer
        Dim sp As String = "spDeleteEmpTransition"
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@TransitionHistoryID", TransitionHistoryID)
                cmd.ExecuteNonQuery()
                con.Close()
                Return 1
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region "Emp info by id"
    Public Function fnGetEmpInformationByID(ByVal EmployeeID As String) As clsEmployeeInfo
        Dim EmployeeInfo As New clsEmployeeInfo()
        Dim sp As String = "spGetEmployeeInfoByID"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmployeeInfo.UserID = dr.Item("UserID")
                    EmployeeInfo.Password = dr.Item("Password")
                    EmployeeInfo.UserType = dr.Item("UserType")
                    EmployeeInfo.EmployeeName = dr.Item("EmployeeName")
                    EmployeeInfo.EmpCode = dr.Item("EmpCode")
                    EmployeeInfo.EmpTypeID = dr.Item("EmpTypeID")
                    EmployeeInfo.DateOfBirth = dr.Item("DateOfBirth")
                    EmployeeInfo.BasicSalary = dr.Item("BasicSalary")
                    EmployeeInfo.JoiningDate = dr.Item("JoiningDate")
                    EmployeeInfo.ConfirmationDate = dr.Item("ConfirmationDate")
                    EmployeeInfo.PromotionDate = dr.Item("PromotionDate")
                    EmployeeInfo.ContractExpiryDate = dr.Item("ContractExpiryDate")
                    EmployeeInfo.ContractRenewalDate = dr.Item("ContractRenewalDate")
                    EmployeeInfo.TerminationTypeID = dr.Item("TerminationTypeID")
                    EmployeeInfo.TerminationDate = dr.Item("TerminationDate")
                    EmployeeInfo.RemarksOnTermination = dr.Item("RemarksOnTermination")
                    EmployeeInfo.JoiningDesignationID = dr.Item("JoiningDesignationID")
                    EmployeeInfo.OfficialDesignationID = dr.Item("OfficialDesignationID")
                    EmployeeInfo.FunctionalDesignationID = dr.Item("FunctionalDesignationID")
                    EmployeeInfo.DepartmentID = dr.Item("DepartmentID")
                    EmployeeInfo.ULCBranchID = dr.Item("ULCBranchID")
                    EmployeeInfo.CurrentSupervisor = dr.Item("CurrentSupervisor")
                    EmployeeInfo.JDno = dr.Item("JDno")
                    EmployeeInfo.Status = dr.Item("Status")
                    EmployeeInfo.BankID = dr.Item("BankID")
                    EmployeeInfo.BranchID = dr.Item("BranchID")
                    EmployeeInfo.BankAccountNo = dr.Item("BankAccountNo")
                    EmployeeInfo.Email = dr.Item("Email")
                    EmployeeInfo.EntryExamScore = dr.Item("EntryExamScore")
                    EmployeeInfo.PromotionalExamScore = dr.Item("PromotionalExamScore")
                    EmployeeInfo.isActive = dr.Item("isActive")
                    EmployeeInfo.LeaveApprover = dr.Item("LeaveApprover")
                    EmployeeInfo.LeaveRecommender = dr.Item("LeaveRecommender")
                    EmployeeInfo.IsPermittedToShowOwn = dr.Item("IsPermittedToShowOwn")
                    EmployeeInfo.IsPermittedToShowOthers = dr.Item("IsPermittedToShowOthers")
                    EmployeeInfo.AttendanceID = dr.Item("AttendanceID")
                    EmployeeInfo.ProbationEffectiveDate = dr.Item("ProbationEffectiveDate")
                    EmployeeInfo.ProbationPeriod = dr.Item("ProbationPeriod")
                    EmployeeInfo.AutoAdvTaxDeduction = dr.Item("AutoAdvTaxDeduction")
                    EmployeeInfo.IncludedInPayroll = dr.Item("IncludedInPayroll")
                End While
                con.Close()

                Return EmployeeInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Edit Basic Employee Info "
    Public Function fnEditBasicEmpInfo(ByVal EmpInfo As clsEmployeeInfo) As Integer
        Dim sp As String = "spEditBasicEmpInfo"
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmpInfo.EmployeeID)
                cmd.Parameters.AddWithValue("@UserType", EmpInfo.UserType)
                cmd.Parameters.AddWithValue("@UserID", EmpInfo.UserID)
                cmd.Parameters.AddWithValue("@Password", EmpInfo.Password)
                cmd.Parameters.AddWithValue("@BasicSalary", EmpInfo.BasicSalary)
                cmd.Parameters.AddWithValue("@EmpCode", EmpInfo.EmpCode)
                cmd.Parameters.AddWithValue("@isActive", EmpInfo.isActive)
                cmd.Parameters.AddWithValue("@IncludedInPayroll", EmpInfo.IncludedInPayroll)
                cmd.Parameters.AddWithValue("@IsPermittedToShowOwn", EmpInfo.IsPermittedToShowOwn)
                cmd.Parameters.AddWithValue("@IsPermittedToShowOthers", EmpInfo.IsPermittedToShowOthers)
                cmd.Parameters.AddWithValue("@AttendanceID", EmpInfo.AttendanceID)
                cmd.Parameters.AddWithValue("@ProbationEffectiveDate", EmpInfo.ProbationEffectiveDate)
                cmd.Parameters.AddWithValue("@ProbationPeriod", EmpInfo.ProbationPeriod)
                cmd.Parameters.AddWithValue("@AutoAdvTaxDeduction", EmpInfo.AutoAdvTaxDeduction)
                cmd.Parameters.AddWithValue("@EntryBy", EmpInfo.EntryBy)
                cmd.ExecuteNonQuery()
                con.Close()
                Return 1
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Edit Basic Employee Info Admin "
    Public Function fnEditBasicEmpInfoAdmin(ByVal EmpInfo As clsEmployeeInfo) As Integer
        Dim sp As String = "spEditBasicEmpInfoAdmin"
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmpInfo.EmployeeID)
                cmd.Parameters.AddWithValue("@UserType", EmpInfo.UserType)
                cmd.Parameters.AddWithValue("@UserID", EmpInfo.UserID)
                cmd.Parameters.AddWithValue("@Password", EmpInfo.Password)
                cmd.Parameters.AddWithValue("@EmpCode", EmpInfo.EmpCode)
                cmd.Parameters.AddWithValue("@isActive", EmpInfo.isActive)
                cmd.Parameters.AddWithValue("@IncludedInPayroll", EmpInfo.IncludedInPayroll)
                cmd.Parameters.AddWithValue("@IsPermittedToShowOwn", EmpInfo.IsPermittedToShowOwn)
                cmd.Parameters.AddWithValue("@IsPermittedToShowOthers", EmpInfo.IsPermittedToShowOthers)
                cmd.Parameters.AddWithValue("@AttendanceID", EmpInfo.AttendanceID)
                cmd.Parameters.AddWithValue("@ProbationEffectiveDate", EmpInfo.ProbationEffectiveDate)
                cmd.Parameters.AddWithValue("@ProbationPeriod", EmpInfo.ProbationPeriod)
                cmd.Parameters.AddWithValue("@AutoAdvTaxDeduction", EmpInfo.AutoAdvTaxDeduction)
                cmd.ExecuteNonQuery()
                con.Close()
                Return 1
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Search Employee "

    Public Function fnSearchEmployee(ByVal EmpInfo As clsEmployeeInfo) As DataSet

        Dim sp As String = "spSearchEmployee"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeName", EmpInfo.EmployeeName)
                cmd.Parameters.AddWithValue("@DepartmentID", EmpInfo.DepartmentID)
                cmd.Parameters.AddWithValue("@OfficialDesignationID", EmpInfo.OfficialDesignationID)
                cmd.Parameters.AddWithValue("@ULCBranchID", EmpInfo.ULCBranchID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Search Emp By Name or ID "

    Public Function fnSearchEmpByNameorID(ByVal EmpIDorName As String) As DataSet
        Dim sp As String = "spSearchEmpByNameorID"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmpIDorName", EmpIDorName)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Search Employee For Edit "

    Public Function fnSearchEmployeeForEdit(ByVal EmpInfo As clsEmployeeInfo) As DataSet

        Dim sp As String = "spSearchEmployeeForEdit"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmpIDOrName", EmpInfo.EmpIDOrName)
                cmd.Parameters.AddWithValue("@EmployeeTypeID", EmpInfo.EmpTypeID)
                cmd.Parameters.AddWithValue("@DepartmentID", EmpInfo.DepartmentID)
                cmd.Parameters.AddWithValue("@DesignationID", EmpInfo.OfficialDesignationID)
                cmd.Parameters.AddWithValue("@ULCBranchID", EmpInfo.ULCBranchID)
                cmd.Parameters.AddWithValue("@IsActive", EmpInfo.isActive)
                cmd.Parameters.AddWithValue("@Gender", EmpInfo.Gender)
                cmd.Parameters.AddWithValue("@BloodGroupID", EmpInfo.BloodGroupID)
                cmd.Parameters.AddWithValue("@PerDistrict", EmpInfo.PerDistrict)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Show Org Structure "

    Public Function fnShowOrgStructure(ByVal EmpInfo As clsEmployeeInfo) As DataSet

        Dim sp As String = "spShowOrgStructure"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmpIDOrName", EmpInfo.EmpIDOrName)
                cmd.Parameters.AddWithValue("@EmployeeTypeID", EmpInfo.EmpTypeID)
                cmd.Parameters.AddWithValue("@DesignationID", EmpInfo.OfficialDesignationID)
                cmd.Parameters.AddWithValue("@FunctionalDesignationID", EmpInfo.FunctionalDesignationID)
                cmd.Parameters.AddWithValue("@DepartmentID", EmpInfo.DepartmentID)
                cmd.Parameters.AddWithValue("@ULCBranchID", EmpInfo.ULCBranchID)
                cmd.Parameters.AddWithValue("@IsActive", EmpInfo.isActive)
                cmd.Parameters.AddWithValue("@Gender", EmpInfo.Gender)
                cmd.Parameters.AddWithValue("@CurrentSupervisor", EmpInfo.CurrentSupervisor)
                cmd.Parameters.AddWithValue("@BloodGroupID", EmpInfo.BloodGroupID)
                cmd.Parameters.AddWithValue("@Religion", EmpInfo.Religion)
                cmd.Parameters.AddWithValue("@PerDistrict", EmpInfo.PerDistrict)
                cmd.Parameters.AddWithValue("@ActualBirthDay", EmpInfo.ActualBirthDay)
                cmd.Parameters.AddWithValue("@ActualBirthMonth", EmpInfo.ActualBirthMonth)
                cmd.Parameters.AddWithValue("@JoiningDate", EmpInfo.JoiningDate)
                cmd.Parameters.AddWithValue("@JoiningDateTo", EmpInfo.JoiningDateTo)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get JD List "

    Public Function fnGetJDList() As DataSet

        Dim sp As String = "spGetJDList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Eligible List Of ETA "

    Public Function fnGetEligibleListOfETA() As DataSet

        Dim sp As String = "spGetEligibleListOfETA"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region


    Public Function fnInsertJDAcceptance(ByVal EmployeeJDID As String, ByVal JobDescriptionID As String, ByVal EmployeeID As String) As String
        Dim CandidateID As String
        'Dim rd As SqlDataReader
        CandidateID = ""
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertJDAcceptance", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeJDID", EmployeeJDID)
            cmd.Parameters.AddWithValue("@JobDescriptionID", JobDescriptionID)
            cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)

            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

    Public Function fnUpdateETAInfoByEmp(ByVal Emp As clsEmployeeInfo) As clsResult
        Dim res As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateETAInfoByEmp", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", Emp.EmployeeID)
            cmd.Parameters.AddWithValue("@SecondaryBankID", Emp.SecondaryBankID)
            cmd.Parameters.AddWithValue("@SecondaryBranchID", Emp.SecondaryBranchID)
            cmd.Parameters.AddWithValue("@SecondaryBankAccountNo", Emp.SecondaryBankAccountNo)
            cmd.Parameters.AddWithValue("@Fuel", Emp.Fuel)
            cmd.Parameters.AddWithValue("@DriverAllowance", Emp.DriverAllowance)
            cmd.Parameters.AddWithValue("@VehicleMaintenance", Emp.VehicleMaintenance)
            cmd.Parameters.AddWithValue("@CarSubsidy", Emp.CarSubsidy)
            cmd.Parameters.AddWithValue("@IsEligibleForExternalTA", Emp.IsEligibleForExternalTA)
            cmd.ExecuteNonQuery()
            con.Close()
            res.Success = True
            res.Message = "Updated Successfully."
            Return res
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            res.Success = False
            res.Message = ex.Message
            Return res
        End Try
    End Function

    Public Shared Function EmpJDCount(ByVal EmployeeID As String) As Integer

        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim rtn As Integer
        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
        Try
            cn.Open()
            cmd.Connection = cn

            cmd.CommandText = "select count(1) from dbo.tblEmployeeInfo where JDno in (select JobDescriptionID from dbo.tblUserAcceptanceJD where tblUserAcceptanceJD.EmployeeID ='" + EmployeeID + "') and dbo.tblEmployeeInfo.EmployeeID='" & EmployeeID & " '"
            rd = cmd.ExecuteReader()

            rtn = 0
            While (rd.Read())
                rtn = rd.GetValue(0)
            End While
            cn.Close()
            Return rtn
        Catch ex As SqlException
            cn.Close()
            Return 0
        End Try
    End Function

#Region " Get Emp DashBoard "

    Public Function fnGetEmpDashBoard(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmpDashBoard"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)

                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Emp List By Designation "

    Public Function fnGetEmpListByDesignation(ByVal DesignationID As String) As DataSet

        Dim sp As String = "spGetEmpListByDesignation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DesignationID", DesignationID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

    Public Function fnHasConfidentialAccess(ByVal EmployeeID As String) As Boolean

        Dim sp As String = "spHasConfidentialAccess"
        Dim dr As SqlDataReader
        Dim ConfidentialAccess As Boolean = 0
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ConfidentialAccess = dr.Item("ConfidentialAccess")
                End While
                con.Close()
                Return ConfidentialAccess
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return False
        End Try
    End Function

    Public Function fnGetETAInfoByEmp(ByVal EmployeeID As String) As clsEmployeeInfo

        Dim sp As String = "spGetETAInfoByEmp"
        Dim dr As SqlDataReader
        Dim Emp As New clsEmployeeInfo()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    Emp.SecondaryBankID = dr.Item("SecondaryBankID")
                    Emp.SecondaryBranchID = dr.Item("SecondaryBranchID")
                    Emp.SecondaryBankAccountNo = dr.Item("SecondaryBankAccountNo")
                    Emp.Fuel = dr.Item("Fuel")
                    Emp.DriverAllowance = dr.Item("DriverAllowance")
                    Emp.VehicleMaintenance = dr.Item("VehicleMaintenance")
                    Emp.CarSubsidy = dr.Item("CarSubsidy")
                    Emp.IsEligibleForExternalTA = dr.Item("IsEligibleForExternalTA")
                End While
                con.Close()
                Return Emp
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    '' ***************************************

    Public Function fnInsertBasicInfo(ByVal EmployeeID As String, ByVal BasicInfo As clsEmployeeInfo, ByVal AttachmentFileName As String, ByVal DocFileNameSign As String, ByVal UserDocuments As String, ByVal UserID As String) As String
        Dim CandidateID As String
        Dim rd As SqlDataReader
        CandidateID = ""
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertEmployeeBasicInfo", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
            cmd.Parameters.AddWithValue("@Name", BasicInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@FatherName", BasicInfo.FathersName)
            cmd.Parameters.AddWithValue("@FathersOccupation", BasicInfo.FathersOccupation)
            cmd.Parameters.AddWithValue("@MotherName", BasicInfo.MothersName)
            cmd.Parameters.AddWithValue("@MothersOccupation", BasicInfo.MothersOccupation)
            cmd.Parameters.AddWithValue("@SpouseName", BasicInfo.SpouseName)
            cmd.Parameters.AddWithValue("@SpouseOccupation", BasicInfo.SpouseOccupation)
            cmd.Parameters.AddWithValue("@NoOfChildrenAge", BasicInfo.NoOfChildrenAge)
            cmd.Parameters.AddWithValue("@SibblingsNameOccupation", BasicInfo.SibblingsNameOccupation)
            cmd.Parameters.AddWithValue("@Gender", BasicInfo.Gender)
            cmd.Parameters.AddWithValue("@NIDNo", BasicInfo.NIDNo)
            cmd.Parameters.AddWithValue("@Nationality", BasicInfo.Nationality)
            cmd.Parameters.AddWithValue("@Religion", BasicInfo.Religion)
            cmd.Parameters.AddWithValue("@PresentAddress", BasicInfo.PresentAddress)
            cmd.Parameters.AddWithValue("@PreDistrict", BasicInfo.PreDistrict)
            cmd.Parameters.AddWithValue("@PreThana", BasicInfo.PreThana)
            cmd.Parameters.AddWithValue("@PermanentAddress", BasicInfo.PermanentAddress)
            cmd.Parameters.AddWithValue("@PerDistrict", BasicInfo.PerDistrict)
            cmd.Parameters.AddWithValue("@PerThana", BasicInfo.PerThana)
            cmd.Parameters.AddWithValue("@MobileNumber", BasicInfo.MobileNo)
            cmd.Parameters.AddWithValue("@EMail", BasicInfo.EMail)
            cmd.Parameters.AddWithValue("@AltEMail", BasicInfo.AlternateEmail)
            cmd.Parameters.AddWithValue("@AttachmentFileName", AttachmentFileName)
            cmd.Parameters.AddWithValue("@DocFileNameSign", DocFileNameSign)
            cmd.Parameters.AddWithValue("@RelationshipStatus", BasicInfo.RelationshipStatus)
            cmd.Parameters.AddWithValue("@BloodGroupID", BasicInfo.BloodGroupID)
            cmd.Parameters.AddWithValue("@UserDocuments", UserDocuments)
            cmd.Parameters.AddWithValue("@UserID", UserID)






            'cmd.ExecuteNonQuery()
            rd = cmd.ExecuteReader()
            rd.Read()
            CandidateID = rd.GetValue(0)
            con.Close()
            'Return CandidateID
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            'Return "0"
        End Try
        Return CandidateID
    End Function

    Public Function fnGetEmployeeBasicInformation(ByVal EmployeeID As String) As clsEmployeeInfo
        Dim BasicInfo As New clsEmployeeInfo()
        Dim sp As String = "spGetEmployeeBasicInfo"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    BasicInfo.EmployeeName = dr.Item("Name")
                    BasicInfo.FathersName = dr.Item("FathersName")
                    BasicInfo.MothersName = dr.Item("MothersName")
                    BasicInfo.SpouseName = dr.Item("SpouseName")
                    BasicInfo.Gender = dr.Item("Gender")
                    BasicInfo.NIDNo = dr.Item("NIDNo")
                    BasicInfo.Nationality = dr.Item("Nationality")
                    BasicInfo.Religion = dr.Item("Religion")
                    BasicInfo.PresentAddress = dr.Item("PresentAddress")
                    BasicInfo.PreDistrict = dr.Item("PreDistrict")
                    BasicInfo.PreThana = dr.Item("PreThana")
                    BasicInfo.PermanentAddress = dr.Item("PermanentAddress")
                    BasicInfo.PerDistrict = dr.Item("PerDistrict")
                    BasicInfo.PerThana = dr.Item("PerThana")
                    BasicInfo.MobileNo = dr.Item("MobileNo")
                    BasicInfo.Email = dr.Item("Email")
                    BasicInfo.AlternateEmail = dr.Item("AlternateEmail")
                    BasicInfo.Photos = dr.Item("photos")
                    BasicInfo.FathersOccupation = dr.Item("FathersOccupation")
                    BasicInfo.MothersOccupation = dr.Item("MothersOccupation")
                    BasicInfo.SpouseOccupation = dr.Item("SpouseOccupation")
                    BasicInfo.NoOfChildrenAge = dr.Item("NoOfChildrenAge")
                    BasicInfo.[SibblingsNameOccupation] = dr.Item("SibblingsNameOccupation")
                    BasicInfo.Signature = dr.Item("Signature")
                    BasicInfo.RelationshipStatus = dr.Item("RelationshipStatus")
                    BasicInfo.BloodGroupID = dr.Item("BloodGroupID")
                End While
                con.Close()

                Return BasicInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetEmployeeAllDetails(ByVal EmployeeID As String) As clsEmployeeInfo
        Dim BasicInfo As New clsEmployeeInfo()
        Dim sp As String = "prGetEmployeeAllInformation"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    BasicInfo.EmployeeName = dr.Item("Name")
                    BasicInfo.FathersName = dr.Item("FathersName")
                    BasicInfo.MothersName = dr.Item("MothersName")
                    BasicInfo.SpouseName = dr.Item("SpouseName")
                    BasicInfo.Gender = dr.Item("Gender")
                    BasicInfo.NIDNo = dr.Item("NIDNo")
                    BasicInfo.Nationality = dr.Item("Nationality")
                    BasicInfo.Religion = dr.Item("Religion")
                    BasicInfo.PresentAddress = dr.Item("PresentAddress")
                    BasicInfo.PreDistrict = dr.Item("PreDistrict")
                    BasicInfo.PreThana = dr.Item("PreThana")
                    BasicInfo.PermanentAddress = dr.Item("PermanentAddress")
                    BasicInfo.PerDistrict = dr.Item("PerDistrict")
                    BasicInfo.PerThana = dr.Item("PerThana")
                    BasicInfo.MobileNo = dr.Item("MobileNo")
                    BasicInfo.AlternateEmail = dr.Item("AlternateEmail")
                    BasicInfo.Photos = dr.Item("photos")
                    BasicInfo.FathersOccupation = dr.Item("FathersOccupation")
                    BasicInfo.MothersOccupation = dr.Item("MothersOccupation")
                    BasicInfo.SpouseOccupation = dr.Item("SpouseOccupation")
                    BasicInfo.NoOfChildrenAge = dr.Item("NoOfChildrenAge")
                    BasicInfo.[SibblingsNameOccupation] = dr.Item("SibblingsNameOccupation")
                    BasicInfo.Signature = dr.Item("Signature")
                    BasicInfo.RelationshipStatus = dr.Item("RelationshipStatus")
                    BasicInfo.BloodGroupID = dr.Item("BloodGroupName")
                End While
                con.Close()

                Return BasicInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function GetRegisteredInfo(ByVal EmployeeID As String, ByRef EmpCode As String) As Integer
        Dim sp As String = "spGetEmpCode"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmpCode = dr.Item("EmpCode")
                End While
                con.Close()
                Return 1
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                Return Nothing
            End If
        End Try
        Return 1
    End Function

    '*********************************
    Public Function fnUpdateBasicInfo(ByVal BasicInfo As clsEmployeeInfo) As String
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateEmpBasProfileInfo", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", BasicInfo.EmployeeID)
            cmd.Parameters.AddWithValue("@EmployeeName", BasicInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@JoiningDate", BasicInfo.JoiningDate)
            cmd.Parameters.AddWithValue("@ConfirmationDate", BasicInfo.ConfirmationDate)
            cmd.Parameters.AddWithValue("@OfficialDesignationID", BasicInfo.OfficialDesignationID)
            cmd.Parameters.AddWithValue("@FunctionalDesignationID", BasicInfo.FunctionalDesignationID)
            cmd.Parameters.AddWithValue("@CurrentSupervisor", BasicInfo.CurrentSupervisor)
            cmd.Parameters.AddWithValue("@DateOfBirth", BasicInfo.DateOfBirth)
            cmd.Parameters.AddWithValue("@Gender", BasicInfo.Gender)
            cmd.Parameters.AddWithValue("@Nationality", BasicInfo.Nationality)
            cmd.Parameters.AddWithValue("@BloodGroupID", BasicInfo.BloodGroupID)
            cmd.Parameters.AddWithValue("@NIDNo", BasicInfo.NIDNo)
            cmd.Parameters.AddWithValue("@Religion", BasicInfo.Religion)
            cmd.Parameters.AddWithValue("@FathersName", BasicInfo.FathersName)
            cmd.Parameters.AddWithValue("@FathersOccupation", BasicInfo.FathersOccupation)
            cmd.Parameters.AddWithValue("@MothersName", BasicInfo.MothersName)
            cmd.Parameters.AddWithValue("@MothersOccupation", BasicInfo.MothersOccupation)
            cmd.Parameters.AddWithValue("@SpouseName", BasicInfo.SpouseName)
            cmd.Parameters.AddWithValue("@SpouseOccupation", BasicInfo.SpouseOccupation)
            cmd.Parameters.AddWithValue("@RelationshipStatus", BasicInfo.RelationshipStatus)
            cmd.Parameters.AddWithValue("@MobileNo", BasicInfo.MobileNo)
            cmd.Parameters.AddWithValue("@OfficePhone", BasicInfo.OfficePhone)
            cmd.Parameters.AddWithValue("@OfficeExtension", BasicInfo.OfficeExtension)
            cmd.Parameters.AddWithValue("@EmmergencyConPerName", BasicInfo.EmmergencyConPerName)
            cmd.Parameters.AddWithValue("@EmmerConPerPhone", BasicInfo.EmmerConPerPhone)
            cmd.Parameters.AddWithValue("@RelWithEmmerConPer", BasicInfo.RelWithEmmerConPer)
            cmd.Parameters.AddWithValue("@PresentAddress", BasicInfo.PresentAddress)
            cmd.Parameters.AddWithValue("@PreDistrict", BasicInfo.PreDistrict)
            cmd.Parameters.AddWithValue("@PreThana", BasicInfo.PreThana)
            cmd.Parameters.AddWithValue("@PermanentAddress", BasicInfo.PermanentAddress)
            cmd.Parameters.AddWithValue("@PerDistrict", BasicInfo.PerDistrict)
            cmd.Parameters.AddWithValue("@PerThana", BasicInfo.PerThana)
            cmd.Parameters.AddWithValue("@Photos", BasicInfo.Photos)
            cmd.Parameters.AddWithValue("@Signature", BasicInfo.Signature)
            cmd.Parameters.AddWithValue("@ActualBirthDay", BasicInfo.ActualBirthDay)
            cmd.Parameters.AddWithValue("@ActualBirthMonth", BasicInfo.ActualBirthMonth)
            cmd.Parameters.AddWithValue("@EmpTypeID", BasicInfo.EmpTypeID)
            cmd.Parameters.AddWithValue("@ULCBranchID", BasicInfo.ULCBranchID)
            cmd.Parameters.AddWithValue("@DepartmentID", BasicInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@EMail", BasicInfo.EMail)
            cmd.Parameters.AddWithValue("@AlternateEmail", BasicInfo.AlternateEmail)
            cmd.Parameters.AddWithValue("@BankID", BasicInfo.BankID)
            cmd.Parameters.AddWithValue("@BranchID", BasicInfo.BranchID)
            cmd.Parameters.AddWithValue("@BankAccountNo", BasicInfo.BankAccountNo)
            cmd.Parameters.AddWithValue("@SecondaryBankID", BasicInfo.SecondaryBankID)
            cmd.Parameters.AddWithValue("@SecondaryBranchID", BasicInfo.SecondaryBranchID)
            cmd.Parameters.AddWithValue("@SecondaryBankAccountNo", BasicInfo.SecondaryBankAccountNo)
            cmd.Parameters.AddWithValue("@InsuranceNo", BasicInfo.InsuranceNo)
            cmd.Parameters.AddWithValue("@ApproverID", BasicInfo.ApproverID)
            cmd.Parameters.AddWithValue("@RecommenderID", BasicInfo.RecommenderID)
            cmd.Parameters.AddWithValue("@PrimaryEvaluator", BasicInfo.PrimaryEvaluator)
            cmd.Parameters.AddWithValue("@SecondaryEvaluator", BasicInfo.SecondaryEvaluator)
            cmd.Parameters.AddWithValue("@HealthPlanID", BasicInfo.HealthPlanID)
            cmd.Parameters.AddWithValue("@TinNo", BasicInfo.TinNo)
            cmd.Parameters.AddWithValue("@PassportNo", BasicInfo.PassportNo)
            cmd.Parameters.AddWithValue("@DrivingLicenseNo", BasicInfo.DrivingLicenseNo)
            cmd.Parameters.AddWithValue("@EntryBy", BasicInfo.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

    Public Function fnGetRelationShipStatus() As DataSet

        Dim sp As String = "spGetRelationShipStatus"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetBloodGroup() As DataSet

        Dim sp As String = "spGetBloodGroup"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetOccupationList() As DataSet

        Dim sp As String = "spGetOccupationList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function getDistrictName() As DataSet

        Dim sp As String = "spGetPreDistrictName"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function getUpazillaName(ByVal DistrictID As Integer) As DataSet

        Dim sp As String = "spGetUpazillaName"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DistrictID", DistrictID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetEmployeeBasicProfileInfo(ByVal EmployeeID As String) As clsEmployeeInfo
        Dim BasicInfo As New clsEmployeeInfo()
        Dim sp As String = "spGetEmployeeBasicProfileInfo"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    BasicInfo.EmployeeName = dr.Item("EmployeeName")
                    BasicInfo.FathersName = dr.Item("FathersName")
                    BasicInfo.FathersOccupation = dr.Item("FathersOccupation")
                    BasicInfo.MothersName = dr.Item("MothersName")
                    BasicInfo.MothersOccupation = dr.Item("MothersOccupation")
                    BasicInfo.SpouseName = dr.Item("SpouseName")
                    BasicInfo.SpouseOccupation = dr.Item("SpouseOccupation")
                    BasicInfo.RelationshipStatus = dr.Item("RelationshipStatus")
                    BasicInfo.MobileNo = dr.Item("MobileNo")
                    BasicInfo.OfficePhone = dr.Item("OfficePhone")
                    BasicInfo.OfficeExtension = dr.Item("OfficeExtension")
                    BasicInfo.EmmergencyConPerName = dr.Item("EmmergencyConPerName")
                    BasicInfo.EmmerConPerPhone = dr.Item("EmmerConPerPhone")
                    BasicInfo.RelWithEmmerConPer = dr.Item("RelWithEmmerConPer")
                    BasicInfo.PresentAddress = dr.Item("PresentAddress")
                    BasicInfo.PreDistrict = dr.Item("PreDistrict")
                    BasicInfo.PreThana = dr.Item("PreThana")
                    BasicInfo.PermanentAddress = dr.Item("PermanentAddress")
                    BasicInfo.PerDistrict = dr.Item("PerDistrict")
                    BasicInfo.PerThana = dr.Item("PerThana")
                    BasicInfo.Gender = dr.Item("Gender")
                    BasicInfo.NIDNo = dr.Item("NIDNo")
                    BasicInfo.Nationality = dr.Item("Nationality")
                    BasicInfo.Religion = dr.Item("Religion")
                    BasicInfo.BloodGroupID = dr.Item("BloodGroupID")
                    BasicInfo.DateOfBirth = dr.Item("DateOfBirth")
                    BasicInfo.JoiningDate = dr.Item("JoiningDate")
                    BasicInfo.ConfirmationDate = dr.Item("ConfirmationDate")
                    BasicInfo.OfficialDesignation = dr.Item("OfficialDesignationID")
                    BasicInfo.FunctionalDesignation = dr.Item("FunctionalDesignationID")
                    BasicInfo.CurrentSupervisor = dr.Item("CurrentSupervisor")
                    BasicInfo.Photos = dr.Item("photos")
                    BasicInfo.Signature = dr.Item("Signature")
                    BasicInfo.ActualBirthDay = dr.Item("ActualBirthDay")
                    BasicInfo.ActualBirthMonth = dr.Item("ActualBirthMonth")
                    BasicInfo.Branch = dr.Item("ULCBranchID")
                    BasicInfo.Department = dr.Item("DepartmentID")
                    BasicInfo.EmpTypeID = dr.Item("EmpTypeID")
                    BasicInfo.Email = dr.Item("Email")
                    BasicInfo.AlternateEmail = dr.Item("AlternateEmail")
                    BasicInfo.BankID = dr.Item("BankID")
                    BasicInfo.BranchID = dr.Item("BranchID")
                    BasicInfo.BankAccountNo = dr.Item("BankAccountNo")
                    BasicInfo.SecondaryBankID = dr.Item("SecondaryBankID")
                    BasicInfo.SecondaryBranchID = dr.Item("SecondaryBranchID")
                    BasicInfo.SecondaryBankAccountNo = dr.Item("SecondaryBankAccountNo")
                    BasicInfo.HealthPlanID = dr.Item("HealthPlanID")
                    BasicInfo.InsuranceNo = dr.Item("InsuranceNo")
                    BasicInfo.TinNo = dr.Item("TinNo")
                    BasicInfo.PassportNo = dr.Item("PassportNo")
                    BasicInfo.DrivingLicenseNo = dr.Item("DrivingLicenseNo")
                    BasicInfo.ApproverID = dr.Item("LeaveApprover")
                    BasicInfo.RecommenderID = dr.Item("LeaveRecommender")
                    BasicInfo.PrimaryEvaluator = dr.Item("PrimaryEvaluator")
                    BasicInfo.SecondaryEvaluator = dr.Item("SecondaryEvaluator")
                End While
                con.Close()
                Return BasicInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetBasicProfile(ByVal EmployeeID As String) As clsEmployeeInfo
        Dim BasicInfo As New clsEmployeeInfo()
        Dim sp As String = "spGetBasicInfoProfile"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    BasicInfo.EmployeeName = dr.Item("Name")
                    BasicInfo.EmpCode = dr.Item("EmpCode")
                    BasicInfo.OfficialDesignation = dr.Item("OfficialDesignation")
                    BasicInfo.FunctionalDesignation = dr.Item("FunctionalDesignation")
                    BasicInfo.Department = dr.Item("DepartmentName")
                    BasicInfo.CurrentSupervisor = dr.Item("CurrentSupervisor")
                    BasicInfo.EmpType = dr.Item("EmployeeTypeName")
                    BasicInfo.ServiceLength = dr.Item("ServiceLength")
                    BasicInfo.Branch = dr.Item("ULCBranchName")
                    BasicInfo.Photos = dr.Item("Photos")
                    BasicInfo.CandidateID = dr.Item("CandidateID")
                End While
                con.Close()
                Return BasicInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Sub fnGetEmpNameCode(ByVal EmployeeID As String, ByRef EmployeeName As String, ByRef EmployeeCode As String)
        Dim sp As String = "spGetEmpNameID"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmployeeName = dr.Item("EmployeeName")
                    EmployeeCode = dr.Item("EmpCode")
                End While
                con.Close()
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
        End Try
    End Sub

    Public Function EmpCountForImage(ByVal EmployeeID As String) As Integer
        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim Count As Integer
        Try
            con.Open()
            cmd.Connection = con

            cmd.CommandText = "Select Count(1) from tblEmployeeInfo where ISNULL(Photos,'') <> '' and EmployeeID = '" & EmployeeID & "'"
            rd = cmd.ExecuteReader()
            Count = 0
            While (rd.Read())
                Count = rd.GetValue(0)
            End While
            con.Close()
            Return Count
        Catch ex As SqlException
            con.Close()
            Return Nothing
        End Try
    End Function



    Public Function fnGetDesigForPromotion(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetDesigForPromotion"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetOfficialDesignation() As DataSet

        Dim sp As String = "spGetOfficialDesignation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGratuityCalculation(ByVal AsOnDate As DateTime) As DataSet

        Dim sp As String = "spGratuityCalculation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@AsOnDate", AsOnDate)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    '********************* Employee Settings Info DAta  acess


    Public Function fnGetHealthPlanByDesignation(ByVal DesignationID As String) As String
        Dim HealthPlanID As String = ""
        Dim sp As String = "spGetHealthPlanByDesignation"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DesignationID", DesignationID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    HealthPlanID = dr.Item("HealthPlanID")
                End While
                con.Close()

                Return HealthPlanID
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return ""
        End Try
    End Function

    Public Function fnManagePayrollAccess(ByVal EventName As String) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spManagePayrollAccess", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Event", EventName)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

    Public Function fnCheckForPayrollAccess() As String
        Dim PayrollAccess As String = ""
        Dim sp As String = "spCheckForPayrollAccess"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                dr = cmd.ExecuteReader()
                While dr.Read()
                    PayrollAccess = dr.Item("PayrollAccess")
                End While
                con.Close()
                Return PayrollAccess
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return ""
        End Try
    End Function


    '************************** all emp. info
    Public Shared Function SubmitExperienceInformation(ByVal EmployeeID As String, ByVal isoExperienceParts As String) As String
        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

        Dim ApplicationID As String
        Try
            cn.Open()
            cmd.Connection = cn
            cmd.CommandText = "exec prEmployeeExpInputAdd '" & EmployeeID & "','" & isoExperienceParts & "'"
            rd = cmd.ExecuteReader()

            rd.Read()
            'ApplicationID = rd.GetValue(0)

            cn.Close()
            Return 1
        Catch ex As SqlException
            cn.Close()
            ApplicationID = ""
            Return 0
        End Try

        'Return ApplicationID
    End Function

    Public Function SubmitEducationInformation(ByVal EmployeeID As String, ByVal isoParts As String) As String
        Dim ApplicationID As String
        Try
            Dim cmd As SqlCommand = New SqlCommand("spEmployeeEducationInputAdd", con)
            cmd.CommandType = CommandType.StoredProcedure
            con.Open()
            cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
            cmd.Parameters.AddWithValue("@isoParts", isoParts)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As SqlException
            con.Close()
            ApplicationID = ""
            Return 0
        End Try
    End Function

    Public Shared Function SubmitTrainingInformation(ByVal EmployeeID As String, ByVal isoTrainingParts As String) As String
        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

        Dim ApplicationID As String
        Try
            cn.Open()
            cmd.Connection = cn
            cmd.CommandText = "exec prEmployeeTrainingInputAdd '" & EmployeeID & "','" & isoTrainingParts & "'"
            rd = cmd.ExecuteReader()

            rd.Read()
            'ApplicationID = rd.GetValue(0)

            cn.Close()
            Return 1
        Catch ex As SqlException
            cn.Close()
            ApplicationID = ""
            Return 0
        End Try

        'Return ApplicationID
    End Function

    Public Function SubmitOtherInformation(ByVal EmployeeID As String, ByVal isoProfessionalCertificationParts As String) As String
        Dim ApplicationID As String
        Try
            Dim cmd As SqlCommand = New SqlCommand("prEmployeeProCerInputAdd", con)
            cmd.CommandType = CommandType.StoredProcedure
            con.Open()
            cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
            cmd.Parameters.AddWithValue("@isoProfessionalCertificationParts", isoProfessionalCertificationParts)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As SqlException
            con.Close()
            ApplicationID = ""
            Return 0
        End Try
    End Function

    Public Function fnGetEducationInformation(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmployeeEduInformation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function AddInstitutionName(ByVal InstitutionName As String, ByVal IsActive As Integer, ByVal EntryBy As String) As Integer

        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertInstitutionName", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@InstitutionName", InstitutionName)
            cmd.Parameters.AddWithValue("@IsActive", IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", EntryBy)

            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

    Public Function fnGetInstitutionList() As DataSet

        Dim sp As String = "spGetInstitutionList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function


    Public Shared Function CandidateCount(ByVal UserID As String) As Integer

        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim rtn As Integer
        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
        Try
            cn.Open()
            cmd.Connection = cn

            cmd.CommandText = "Select count(1) from tblCandidateBasicInfo where UserID='" & UserID & "'"
            rd = cmd.ExecuteReader()

            rtn = 0
            While (rd.Read())
                rtn = rd.GetValue(0)
            End While
            cn.Close()
            Return rtn
        Catch ex As SqlException
            cn.Close()
            Return 0
        End Try
    End Function

    Public Function fnGetExperienceInformation(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmployeeExpInformation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add("@EmployeeID", SqlDbType.VarChar, 50).Value = EmployeeID
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetTrainingInformation(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmployeeTrainingInformation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add("@EmployeeID", SqlDbType.VarChar, 50).Value = EmployeeID
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetProCertificationInformation(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmployeeProCertiInformation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add("@EmployeeID", SqlDbType.VarChar, 50).Value = EmployeeID
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function


    Public Function CandidateFindOut(ByVal CandidateID As String, ByVal tblName As String) As Integer

        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim rtn As Integer
        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
        Try
            cn.Open()
            cmd.Connection = cn

            cmd.CommandText = "Select count(1) from " & tblName & " where CandidateID='" & CandidateID & "'"
            rd = cmd.ExecuteReader()

            rtn = 0
            While (rd.Read())
                rtn = rd.GetValue(0)
            End While
            cn.Close()
            Return rtn
        Catch ex As SqlException
            cn.Close()
            Return 0
        End Try
    End Function

    Public Function CandidateFindOutForEducation(ByVal CandidateID As String) As Integer

        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim rtn As Integer
        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
        Try
            cn.Open()
            cmd.Connection = cn

            cmd.CommandText = "Select count(1) from tblCandidateEducationInfo inner join dbo.tblExamName on dbo.tblExamName.ExamID=tblCandidateEducationInfo.ExamID where (tblExamName.ExamName='Honors' or tblExamName.ExamName='Degree' ) and CandidateID='" & CandidateID & "'"
            rd = cmd.ExecuteReader()

            rtn = 0
            While (rd.Read())
                rtn = rd.GetValue(0)
            End While
            cn.Close()
            Return rtn
        Catch ex As SqlException
            cn.Close()
            Return 0
        End Try
    End Function

    Public Function EmployeeCount(ByVal EmployeeID As String) As Integer

        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim rtn As Integer
        Try
            con.Open()
            cmd.Connection = con

            cmd.CommandText = "Select count(1) from tblEmployeeBasicInfo where EmployeeID='" & EmployeeID & "'"
            rd = cmd.ExecuteReader()

            rtn = 0
            While (rd.Read())
                rtn = rd.GetValue(0)
            End While
            con.Close()
            Return rtn
        Catch ex As SqlException
            If con.State = ConnectionState.Open Then
                con.Close()
                Return 0
            End If
        End Try
    End Function

    Public Function fnGetInstituteName() As DataSet

        Dim sp As String = "spGetInstitutionName"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetExamName() As DataSet

        Dim sp As String = "spGetExamName"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetMajorName() As DataSet

        Dim sp As String = "spGetMajorTypeName"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function CheckPermissionForOwnInfo(ByVal LoginUserId As String) As Boolean
        Dim sp As String = "spPermissionForOwnInfo"
        Dim dr As SqlDataReader
        Dim ReturnValue As Boolean
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LoginUserId", LoginUserId)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ReturnValue = dr.Item("Result")
                End While
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                Return Nothing
            End If
        End Try
        Return ReturnValue
    End Function

    Public Function CheckPermissionForOthers(ByVal LoginUserId As String) As String
        Dim sp As String = "spPermissionForOthers"
        Dim dr As SqlDataReader
        Dim ReturnValue As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LoginUserId", LoginUserId)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ReturnValue = dr.Item("Result")
                End While
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                Return Nothing
            End If
        End Try
        Return ReturnValue
    End Function

    Public Function fnGetEmpCallLog(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmpCallLog"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetPrintActivityByUser(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetPrintActivityByUser"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetAssetList(ByVal UserID As String) As DataSet

        Dim sp As String = "spGetAssetList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@UserID", UserID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetAllCallLog() As DataSet
        Dim sp As String = "spGetAllCallLog"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetEmpPerformance(ByVal Year As Integer) As DataSet
        Dim sp As String = "spGetEmpPerformance"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Year", Year)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

End Class
