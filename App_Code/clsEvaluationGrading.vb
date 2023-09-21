Imports Microsoft.VisualBasic

Public Class clsEvaluationGrading

    Dim _EvaluationGradingID, _GradeText, _GradeType, _EntryBy As String

    Public Property EvaluationGradingID() As String
        Get
            Return _EvaluationGradingID
        End Get
        Set(ByVal value As String)
            _EvaluationGradingID = value
        End Set
    End Property

    Public Property GradeText() As String
        Get
            Return _GradeText
        End Get
        Set(ByVal value As String)
            _GradeText = value
        End Set
    End Property

    Public Property GradeType() As String
        Get
            Return _GradeType
        End Get
        Set(ByVal value As String)
            _GradeType = value
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

    Dim _GradeValue, _ViewOrder As Integer

    Public Property GradeValue() As Integer
        Get
            Return _GradeValue
        End Get
        Set(ByVal value As Integer)
            _GradeValue = value
        End Set
    End Property

    Public Property ViewOrder() As Integer
        Get
            Return _ViewOrder
        End Get
        Set(ByVal value As Integer)
            _ViewOrder = value
        End Set
    End Property

    Dim _IsActive As Boolean

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
        End Set
    End Property

    Dim _EntryDate As DateTime

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

End Class
