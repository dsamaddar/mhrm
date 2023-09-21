Imports Microsoft.VisualBasic

Public Class clsTrainingTopic
    Dim _TrainingTopicID, _TrngSubjectID, _TrngTopic, _EntryBy As String
    Public Property TrainingTopicID() As String
        Get
            Return _TrainingTopicID
        End Get
        Set(ByVal value As String)
            _TrainingTopicID = value
        End Set
    End Property
    Public Property TrngSubjectID() As String
        Get
            Return _TrngSubjectID
        End Get
        Set(ByVal value As String)
            _TrngSubjectID = value
        End Set
    End Property
    Public Property TrngTopic() As String
        Get
            Return _TrngTopic
        End Get
        Set(ByVal value As String)
            _TrngTopic = value
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
End Class
