Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsDesignation

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _DesignationID, _DesignationName, _DesignationLabel, _DesignationType, _HealthPlanID, _EvaluationGroupID, _EntryBy As String

    Public Property DesignationID() As String
        Get
            Return _DesignationID
        End Get
        Set(ByVal value As String)
            _DesignationID = value
        End Set
    End Property

    Public Property DesignationName() As String
        Get
            Return _DesignationName
        End Get
        Set(ByVal value As String)
            _DesignationName = value
        End Set
    End Property

    Public Property DesignationLabel() As String
        Get
            Return _DesignationLabel
        End Get
        Set(ByVal value As String)
            _DesignationLabel = value
        End Set
    End Property

    Public Property DesignationType() As String
        Get
            Return _DesignationType
        End Get
        Set(ByVal value As String)
            _DesignationType = value
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

    Public Property EvaluationGroupID() As String
        Get
            Return _EvaluationGroupID
        End Get
        Set(ByVal value As String)
            _EvaluationGroupID = value
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

    Dim _NoticePeriod, _intOrder, _Fuel As Integer

    Public Property NoticePeriod() As Integer
        Get
            Return _NoticePeriod
        End Get
        Set(ByVal value As Integer)
            _NoticePeriod = value
        End Set
    End Property

    Public Property intOrder() As Integer
        Get
            Return _intOrder
        End Get
        Set(ByVal value As Integer)
            _intOrder = value
        End Set
    End Property

    Public Property Fuel() As Integer
        Get
            Return _Fuel
        End Get
        Set(ByVal value As Integer)
            _Fuel = value
        End Set
    End Property

    Dim _TransportAllowance, _DriverAllowance, _VehicleMaintenance, _CarSubsidy, _MobileAllowance As Double

    Public Property TransportAllowance() As Double
        Get
            Return _TransportAllowance
        End Get
        Set(ByVal value As Double)
            _TransportAllowance = value
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

    Public Property MobileAllowance() As Double
        Get
            Return _MobileAllowance
        End Get
        Set(ByVal value As Double)
            _MobileAllowance = value
        End Set
    End Property

    Dim _isActive As Boolean

    Public Property isActive() As Boolean
        Get
            Return _isActive
        End Get
        Set(ByVal value As Boolean)
            _isActive = value
        End Set
    End Property

    Public Function fnInsertDesignation(ByVal Designation As clsDesignation) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertDesignation", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DesignationName", Designation.DesignationName)
            cmd.Parameters.AddWithValue("@DesignationLabel", Designation.DesignationLabel)
            cmd.Parameters.AddWithValue("@DesignationType", Designation.DesignationType)
            cmd.Parameters.AddWithValue("@HealthPlanID", Designation.HealthPlanID)
            cmd.Parameters.AddWithValue("@intOrder", Designation.intOrder)
            cmd.Parameters.AddWithValue("@EvaluationGroupID", Designation.EvaluationGroupID)
            cmd.Parameters.AddWithValue("@Fuel", Designation.Fuel)
            cmd.Parameters.AddWithValue("@DriverAllowance", Designation.DriverAllowance)
            cmd.Parameters.AddWithValue("@VehicleMaintenance", Designation.VehicleMaintenance)
            cmd.Parameters.AddWithValue("@CarSubsidy", Designation.CarSubsidy)
            cmd.Parameters.AddWithValue("@NoticePeriod", Designation.NoticePeriod)
            cmd.Parameters.AddWithValue("@MobileAllowance", Designation.MobileAllowance)
            cmd.Parameters.AddWithValue("@TransportAllowance", Designation.TransportAllowance)
            cmd.Parameters.AddWithValue("@IsActive", Designation.isActive)
            cmd.Parameters.AddWithValue("@EntryBy", Designation.EntryBy)
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

    Public Function fnGetDesignationList() As DataSet
        Dim sp As String = "spGetDesignation"
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

    Public Function fnUpdateDesignation(ByVal Designation As clsDesignation) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateDesignation", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DesignationID", Designation.DesignationID)
            cmd.Parameters.AddWithValue("@DesignationName", Designation.DesignationName)
            cmd.Parameters.AddWithValue("@DesignationLabel", Designation.DesignationLabel)
            cmd.Parameters.AddWithValue("@DesignationType", Designation.DesignationType)
            cmd.Parameters.AddWithValue("@HealthPlanID", Designation.HealthPlanID)
            cmd.Parameters.AddWithValue("@intOrder", Designation.intOrder)
            cmd.Parameters.AddWithValue("@EvaluationGroupID", Designation.EvaluationGroupID)
            cmd.Parameters.AddWithValue("@Fuel", Designation.Fuel)
            cmd.Parameters.AddWithValue("@DriverAllowance", Designation.DriverAllowance)
            cmd.Parameters.AddWithValue("@VehicleMaintenance", Designation.VehicleMaintenance)
            cmd.Parameters.AddWithValue("@CarSubsidy", Designation.CarSubsidy)
            cmd.Parameters.AddWithValue("@NoticePeriod", Designation.NoticePeriod)
            cmd.Parameters.AddWithValue("@MobileAllowance", Designation.MobileAllowance)
            cmd.Parameters.AddWithValue("@TransportAllowance", Designation.TransportAllowance)
            cmd.Parameters.AddWithValue("@IsActive", Designation.isActive)

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

End Class
