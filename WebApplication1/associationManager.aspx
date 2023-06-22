<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="associationManager.aspx.cs" Inherits="WebApplication1.associationManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sports Association Manager</title>
    <style>
        body{
            background-color:#111;
            margin:0;
            font-family:sans-serif;
        }
        *{
            box-sizing:border-box;
        }
         h1{
            text-align:center;
            color:white;
            font-size:35px;
            margin:10px;
        }
        .wrap{
            padding:10px;
            display:flex;
            justify-content:center;
            flex-wrap:wrap;
            gap:20px;
        }
        .matches{
            display:flex;
            flex-direction:column;
            gap:20px;
        }
        .right{
            display:flex;
            flex-direction:column;
            gap:20px;
        }
        .add-or-delete{
            background-color:#eee;
            padding:35px 55px;
            border-radius:15px;
            max-width:560px;
            display:flex;
            flex-direction:column;
            gap:3px;
            justify-content:center;
            align-items:center;
            height:300px;
        }
        .txtbox{
            width:220px;
            height:32px;
            border:1px solid #ddd;
            padding:10px;
            border-radius:10px;
            font-size:16px;
        }

        .btn{
            padding:8px 15px;
            background-color: #04AA6D;
            border-radius:5px;
            color:white;
            border:none;
            cursor:pointer;
            transition:.3s;
            width:70px;
        }
        .btn:hover{
            box-shadow:0px 0px 5px -2px #666
        }

        .for-table{
            background-color:#eee;
            padding:30px;
            border-radius:15px;
            min-height:300px;

        }

        .scroll{
            max-height:298px;
            overflow:scroll;
        }

        #table1, #table2 , #table3{
            width:100%;
        }
        .row {background-color: #ddd;}

        .cell{ 
           padding:10px;
        }
        .header{
            background-color: darkslategray;
            color: white;
        }
        .field{
            display:flex;
            flex-wrap:wrap;
            gap:10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Sports Association Manager</h1>
        <div class="wrap">
           
            <div class="matches">
                <div class="for-table">
                    <h2 style="margin-top:0; text-align:center;">Upcoming matches</h2>
                    <div class="scroll">
                        <asp:Table ID="table1"  runat="server">
                             <asp:TableHeaderRow CssClass="header">
                                 <asp:TableCell CssClass="cell">Host</asp:TableCell>
                                 <asp:TableCell CssClass="cell">Guest</asp:TableCell>
                                 <asp:TableCell CssClass="cell">Start Time</asp:TableCell>
                                 <asp:TableCell CssClass="cell">End Time</asp:TableCell>
                             </asp:TableHeaderRow>
                        </asp:Table>
                    </div>
                </div>

                <div class="for-table">
                    <h2 style="margin-top:0; text-align:center;">Played matches</h2>
                    <div class="scroll">
                        <asp:Table ID="table2"  runat="server">
                            <asp:TableHeaderRow CssClass="header">
                                <asp:TableCell CssClass="cell">Host</asp:TableCell>
                                <asp:TableCell CssClass="cell">Guest</asp:TableCell>
                                <asp:TableCell CssClass="cell">Start Time</asp:TableCell>
                                <asp:TableCell CssClass="cell">End Time</asp:TableCell>
                            </asp:TableHeaderRow>
                        </asp:Table>
                    </div>
                </div>
            </div>

            <div class="right">
                <div class="for-table">
                <h2 style="margin-top:0; text-align:center;">Clubs never competed</h2>
                <div class="scroll">
                    <asp:Table ID="table3"  runat="server">
                        <asp:TableHeaderRow CssClass="header">
                            <asp:TableCell CssClass="cell">First club</asp:TableCell>
                            <asp:TableCell CssClass="cell">Second club</asp:TableCell>
                        </asp:TableHeaderRow>
                    </asp:Table>
                </div>
            </div>

            <div class="add-or-delete">
                <h2 style="text-align:center;margin-top:0;">Add/Delete Match</h2>
                <div class="field">
                     <div style="width:220px;">
                    <label style="font-size:13px;">Host name</label>  
                    <asp:TextBox ID="hostName" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>

                <div style="width:220px;">
                    <label style="font-size:13px;">Guest name</label>     
                    <asp:TextBox ID="guestName" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>

                <div style="width:220px;">
                    <label style="font-size:13px;">Start time</label>
                    <asp:TextBox ID="startTime" runat="server" CssClass="txtbox" textmode="DateTimeLocal"></asp:TextBox>
                </div>

                <div style="width:220px;">
                    <label style="font-size:13px;">End time</label>
                    <asp:TextBox ID="endTime" runat="server" CssClass="txtbox" textmode="DateTimeLocal"></asp:TextBox>
                </div>
                </div>

                <div style="margin-top:20px">
                    <asp:Button runat="server" Text="Delete" CssClass="btn" OnClick="deleteMatch" style="background-color:brown"></asp:Button>
                    <asp:Button runat="server" Text="Add" CssClass="btn" OnClick="addMatch"></asp:Button>
                </div>
            </div>
            </div>
        </div>
    </form>
</body>
</html>
