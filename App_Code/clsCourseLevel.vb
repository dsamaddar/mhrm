Imports Microsoft.VisualBasic

Public Class clsCourseLevel

    Dim _CourseLevelID, _CourseLevel, _EntryBy As String

    Public Property CourseLevelID() As String
        Get
            Return _CourseLevelID
        End Get
        Set(ByVal value As String)
            _CourseLevelID = value
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

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Dim _EntryDate As DateTime

    Public Property EntryDate() As String
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As String)
            _EntryDate = value
        End Set
    End Property

End Class
