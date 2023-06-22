<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="stadiumManager.aspx.cs" Inherits="WebApplication1.stadiumManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Stadium Manager</title>
    <style>
        body{
            background-color:#222;
            margin:0;
            font-family:sans-serif;
        }
        *{
            box-sizing:border-box;
        }

        .wrap{
            padding:30px;
            display:flex;
            justify-content:center;
            gap:20px;
            flex-wrap:wrap;
        }

        .info{
            display:flex;
            flex-direction:column;
            justify-content:center;
            align-items:flex-start;
            padding:35px 55px;
            background:#eee;
            gap:12px;
            max-width:350px;
            border-radius:15px
        }
        span{
            font-size:18px;
        }
        .reqs{
            background-color:#eee;
            padding:30px;
            border-radius:15px;
        }

        #table1{
            width:100%
        }
        .row {background-color: #ddd;}

        .cell{ 
           padding:10px;
        }
        .header{
            background-color: #04AA6D;
            color: white;
        }
        .accept-or-reject{
            background-color:#eee;
            padding:35px;
            border-radius:15px;
            max-width:350px;
            display:flex;
            flex-direction:column;
            gap:10px;
            justify-content:center;
            align-items:center;

        }
        .all{
            display:flex;
            flex-direction:column;
            gap:20px;
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
        }
        .btn:hover{
            box-shadow:0px 0px 5px -2px #666
        }
        h1{
            color:white;
            text-align:center;
            margin:15px 0 0px;
            
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

</head>
<body>
    <form id="form1" runat="server">
        <h1>Stadium Manager</h1>
        <div class="wrap">
            <div class="all">
                <div class="info">
                    <h2 style="margin:0 0 10px;">Managed Stadium</h2>
                    <span runat="server" id="name"></span>
                    <span runat="server" id="loc"></span>
                    <span runat="server" id="cap"></span>
                    <span runat="server" id="status"></span>
                </div>

                <div class="accept-or-reject">
                    <h2 style="text-align:center;margin-top:0;">Accept/Reject Request</h2>
                   
                    <asp:TextBox ID="hostName" runat="server" CssClass="txtbox" placeholder="Host name"></asp:TextBox>
                    
                    <asp:TextBox ID="guestName" runat="server" CssClass="txtbox" placeholder="Guest name"></asp:TextBox>
                   
                    <div style="width:220px;">
                        <label style="font-size:13px;">start time</label>
                        <asp:TextBox ID="startTime" runat="server" CssClass="txtbox" textmode="DateTimeLocal"></asp:TextBox>
                    </div>

                    <div style="margin-top:20px">
                        <asp:Button runat="server" Text="Accept" CssClass="btn" OnClick="acceptReq"></asp:Button>
                        <asp:Button runat="server" Text="Reject" CssClass="btn" OnClick="rejectReq" style="background-color:brown"></asp:Button>
                    </div>
                </div>

            </div>

            <div class="reqs">
                <h2 style="margin-top:0; text-align:center;">All Host Requests</h2>
                <asp:Table ID="table1"  runat="server">
                     <asp:TableHeaderRow CssClass="header">
                         <asp:TableCell CssClass="cell">Representative</asp:TableCell>
                         <asp:TableCell CssClass="cell">Host</asp:TableCell>
                         <asp:TableCell CssClass="cell">Guest</asp:TableCell>
                         <asp:TableCell CssClass="cell">Start Time</asp:TableCell>
                         <asp:TableCell CssClass="cell">End Time</asp:TableCell>
                         <asp:TableCell CssClass="cell">Status</asp:TableCell>
                     </asp:TableHeaderRow>
                </asp:Table>
            </div>
        </div>
    </form>
</body>
</html>
