Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class clsTrainingInfo

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
    Dim _TrainingID, _TrainingDetails, _TrainingInitiatedBy, _CourseDuration, _Duration, _ClassSchedule, _HighLightsOfTheProgram, _CourseOutLine, _BenefitFromTheProgram, _HowToApply, _ResourcePerson, _RPProfile, _OrganizationID, _EntryBy, _TrngSubjectID, _TrngTypeID, _CourseLevelID, _TrngSubName, _TrngType, _CourseLevel, _OrgName As String

    Public Property TrngSubjectID() As String
        Get
            Return _TrngSubjectID
        End Get
        Set(ByVal value As String)
            _TrngSubjectID = value
        End Set
    End Property

    Public Property TrngTypeID() As String
        Get
            Return _TrngTypeID
        End Get
        Set(ByVal value As String)
            _TrngTypeID = value
        End Set
    End Property

    Public Property CourseLevelID() As String
        Get
            Return _CourseLevelID
        End Get
        Set(ByVal value As String)
            _CourseLevelID = value
        End Set
    End Property

    Public Property TrainingID() As String
        Get
            Return _TrainingID
        End Get
        Set(ByVal value As String)
            _TrainingID = value
        End Set
    End Property

    Public Property TrainingDetails() As String
        Get
            Return _TrainingDetails
        End Get
        Set(ByVal value As String)
            _TrainingDetails = value
        End Set
    End Property

    Public Property TrainingInitiatedBy() As String
        Get
            Return _TrainingInitiatedBy
        End Get
        Set(ByVal value As String)
            _TrainingInitiatedBy = value
        End Set
    End Property

    Public Property CourseDuration() As String
        Get
            Return _CourseDuration
        End Get
        Set(ByVal value As String)
            _CourseDuration = value
        End Set
    End Property

    Public Property Duration() As String
        Get
            Return _Duration
        End Get
        Set(ByVal value As String)
            _Duration = value
        End Set
    End Property

    Public Property ClassSchedule() As String
        Get
            Return _ClassSchedule
        End Get
        Set(ByVal value As String)
            _ClassSchedule = value
        End Set
    End Property

    Public Property HighLightsOfTheProgram() As String
        Get
            Return _HighLightsOfTheProgram
        End Get
        Set(ByVal value As String)
            _HighLightsOfTheProgram = value
        End Set
    End Property

    Public Property CourseOutLine() As String
        Get
            Return _CourseOutLine
        End Get
        Set(ByVal value As String)
            _CourseOutLine = value
        End Set
    End Property

    Public Property BenefitFromTheProgram() As String
        Get
            Return _BenefitFromTheProgram
        End Get
        Set(ByVal value As String)
            _BenefitFromTheProgram = value
        End Set
    End Property

    Public Property HowToApply() As String
        Get
            Return _HowToApply
        End Get
        Set(ByVal value As String)
            _HowToApply = value
        End Set
    End Property

    Public Property ResourcePerson() As String
        Get
            Return _ResourcePerson
        End Get
        Set(ByVal value As String)
            _ResourcePerson = value
        End Set
    End Property

    Public Property RPProfile() As String
        Get
            Return _RPProfile
        End Get
        Set(ByVal value As String)
            _RPProfile = value
        End Set
    End Property

    Public Property OrganizationID() As String
        Get
            Return _OrganizationID
        End Get
        Set(ByVal value As String)
            _OrganizationID = value
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

    Public Property TrngSubName() As String
        Get
            Return _TrngSubName
        End Get
        Set(ByVal value As String)
            _TrngSubName = value
        End Set
    End Property

    Public Property TrngType() As String
        Get
            Return _TrngType
        End Get
        Set(ByVal value As String)
            _TrngType = value
        End Set
    End Property

    Public Property CourseLevel() As String
        Get
            Return _CourseLevel
        End Get
        Set(ByVal value As String)
            _CourseLevel = value
        End Set
    End Property

    Public Property OrgName() As String
        Get
            Return _OrgName
        End Get
        Set(ByVal value As String)
            _OrgName = value
        End Set
    End Property

    Dim _FeesPerAttendees As Double

    Public Property FeesPerAttendees() As Double
        Get
            Return _FeesPerAttendees
        End Get
        Set(ByVal value As Double)
            _FeesPerAttendees = value
        End Set
    End Property

    Dim _ClassesStartsOn, _LastDateOfRegistration, _EntryDate As DateTime

    Public Property ClassesStartsOn() As DateTime
        Get
            Return _ClassesStartsOn
        End Get
        Set(ByVal value As DateTime)
            _ClassesStartsOn = value
        End Set
    End Property

    Public Property LastDateOfRegistration() As DateTime
        Get
            Return _LastDateOfRegistration
        End Get
        Set(ByVal value As DateTime)
            _LastDateOfRegistration = value
        End Set
    End Property

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

#Region " Insert Training Info "

    Public Function fnInsertTrainingInfo(ByVal TrainingInfo As clsTrainingInfo) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertTrainingInfo", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@TrngSubjectID", TrainingInfo.TrngSubjectID)
            cmd.Parameters.AddWithValue("@TrainingDetails", TrainingInfo.TrainingDetails)
            cmd.Parameters.AddWithValue("@TrngTypeID", TrainingInfo.TrngTypeID)
            cmd.Parameters.AddWithValue("@CourseLevelID", TrainingInfo.CourseLevelID)
            cmd.Parameters.AddWithValue("@TrainingInitiatedBy", TrainingInfo.TrainingInitiatedBy)
            cmd.Parameters.AddWithValue("@CourseDuration", TrainingInfo.CourseDuration)
            cmd.Parameters.AddWithValue("@Duration", TrainingInfo.Duration)
            cmd.Parameters.AddWithValue("@ClassesStartsOn", TrainingInfo.ClassesStartsOn)
            cmd.Parameters.AddWithValue("@LastDateOfRegistration", TrainingInfo.LastDateOfRegistration)
            cmd.Parameters.AddWithValue("@ClassSchedule", TrainingInfo.ClassSchedule)
            cmd.Parameters.AddWithValue("@HighLightsOfTheProgram", TrainingInfo.HighLightsOfTheProgram)
            cmd.Parameters.AddWithValue("@CourseOutLine", TrainingInfo.CourseOutLine)
            cmd.Parameters.AddWithValue("@BenefitFromTheProgram", TrainingInfo.BenefitFromTheProgram)
            cmd.Parameters.AddWithValue("@HowToApply", TrainingInfo.HowToApply)
            cmd.Parameters.AddWithValue("@FeesPerAttendees", TrainingInfo.FeesPerAttendees)
            cmd.Parameters.AddWithValue("@ResourcePerson", TrainingInfo.ResourcePerson)
            cmd.Parameters.AddWithValue("@RPProfile", TrainingInfo.RPProfile)
            cmd.Parameters.AddWithValue("@OrganizationID", TrainingInfo.OrganizationID)
            cmd.Parameters.AddWithValue("@EntryBy", TrainingInfo.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Training Information Submitted."
            Return result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            result.Success = False
            result.Message = "Error Found : " & ex.Message
            Return result
        End Try
    End Function
#End Region

#Region " Show Available Training "

    Public Function fnShowAvailableTraining() As DataSet

        Dim sp As String = "spShowAvailableTraining"
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

#Region " Show Training Details ByID  "

    Public Function fnShowTrainingDetailsByID(ByVal TrainingID As String) As clsTrainingInfo
        Dim TrngInfo As New clsTrainingInfo()
        Dim sp As String = "spShowTrainingDetailsByID"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@TrainingID", TrainingID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    TrngInfo.TrainingID = dr.Item("TrainingID")
                    TrngInfo.TrngSubName = dr.Item("TrngSubName")
                    TrngInfo.TrainingDetails = dr.Item("TrainingDetails")
                    TrngInfo.TrngType = dr.Item("TrngType")
                    TrngInfo.CourseLevel = dr.Item("CourseLevel")
                    TrngInfo.TrainingInitiatedBy = dr.Item("TrainingInitiatedBy")
                    TrngInfo.CourseDuration = dr.Item("CourseDuration")
                    TrngInfo.Duration = dr.Item("Duration")
                    TrngInfo.ClassesStartsOn = dr.Item("ClassesStartsOn")
                    TrngInfo.LastDateOfRegistration = dr.Item("LastDateOfRegistration")
                    TrngInfo.ClassSchedule = dr.Item("ClassSchedule")
                    TrngInfo.HighLightsOfTheProgram = dr.Item("HighlightsOfTheProgram")
                    TrngInfo.BenefitFromTheProgram = dr.Item("BenefitFromTheProgram")
                    TrngInfo.HowToApply = dr.Item("HowToApply")
                    TrngInfo.FeesPerAttendees = dr.Item("FeesPerAttendees")
                    TrngInfo.ResourcePerson = dr.Item("ResourcePerson")
                    TrngInfo.RPProfile = dr.Item("RPProfile")
                    TrngInfo.OrgName = dr.Item("OrgName")
                    TrngInfo.EntryBy = dr.Item("EntryBy")
                    TrngInfo.EntryDate = dr.Item("EntryDate")
                End While
                con.Close()
                Return TrngInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

End Class
