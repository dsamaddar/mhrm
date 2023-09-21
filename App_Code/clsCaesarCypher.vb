Imports Microsoft.VisualBasic

Public Class clsCaesarCypher

    Dim OriginalChar() As String = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", _
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", _
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", _
    " ", "-"}
    Dim CypheredChar() As String = {"d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "a", "b", "c", _
    "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "A", "B", "C", _
    ")", "/", "@", ".", "$", "%", "^", "~", "*", "(", _
    " ", "-"}

    Public Function Encrypt(ByVal CharSeq As String) As String

        Dim OutPut As String = ""
        Dim Index As Integer = 0
        Dim i As Integer = 0

        For i = 0 To CharSeq.Length - 1
            Index = Array.IndexOf(OriginalChar, CharSeq(i).ToString())
            If Index = -1 Then
                OutPut = OutPut + "|"
            Else
                OutPut = OutPut + CypheredChar(Index)
            End If
        Next

        Return OutPut

    End Function

    Public Function Decrypt(ByVal CharSeq As String) As String

        Dim OutPut As String = ""
        Dim Index As Integer = 0
        Dim i As Integer = 0

        For i = 0 To CharSeq.Length - 1
            Index = Array.IndexOf(CypheredChar, CharSeq(i).ToString())
            If Index = -1 Then
                OutPut = OutPut + "|"
            Else
                OutPut = OutPut + OriginalChar(Index)
            End If
        Next

        Return OutPut

    End Function

End Class
