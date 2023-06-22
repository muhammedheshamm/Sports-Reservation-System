<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="clubRepresentative.aspx.cs" Inherits="WebApplication1.clubRepresentative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Club Representative</title>
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
            align-items:center;
            gap:20px;
            flex-direction:column;
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
        .matches{
            background-color:#eee;
            padding:30px;
            border-radius:15px;
        }

        #table1, #table2{
            width:100%
        }
        #table2{
            display:none;
        }
        .row {background-color: #ddd;}

        .cell{ 
           padding:10px;
        }
        .header{
            background-color: #04AA6D;
            color: white;
        }
        .stads{
            padding:35px;
            background-color:#eee;
            border-radius:10px;
            display:flex;
            justify-content:center;
            align-items:center;
            flex-direction:column;
        }
        .addreq{
            background-color:#eee;
            padding:35px 55px;
            border-radius:15px;
            max-width:350px;
            display:flex;
            flex-direction:column;
            gap:10px;
            justify-content:center;
            align-items:center;
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
        label{
            font-size:14px;
        }

        .roow{
            display:flex;
            flex-wrap:wrap;
            justify-content:center;
            gap:20px;
            min-width:1000px;
        }

         h1{
            color:white;
            text-align:center;
            margin:15px 0 0px;
            
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Club Representative</h1>
        <div class="wrap">
            <div class="roow">
                <div class="info">
                    <h2 style="margin:0 0 10px;">Represented club</h2>
                    <span runat="server" id="name"></span>
                    <span runat="server" id="loc"></span>
                </div>

                <div class="matches">
                    <h2 style="margin-top:0; text-align:center;">Upcoming matches</h2>
                    <asp:Table ID="table1"  runat="server">
                         <asp:TableHeaderRow CssClass="header">
                             <asp:TableCell CssClass="cell">Host</asp:TableCell>
                             <asp:TableCell CssClass="cell">Guest</asp:TableCell>
                             <asp:TableCell CssClass="cell">Start Time</asp:TableCell>
                             <asp:TableCell CssClass="cell">End Time</asp:TableCell>
                             <asp:TableCell CssClass="cell">Stadium</asp:TableCell>
                         </asp:TableHeaderRow>
                    </asp:Table>
                </div>
            </div>

            <div class="roow">
                <div class="stads">
                    <h2 style="text-align:center;margin-top:0;">View available stadiums starting from: </h2>
                    <asp:TextBox ID="startingfrom" runat="server" textmode="DateTimeLocal" CssClass="txtbox"></asp:TextBox> 
                    <br />
                    <asp:Button runat="server" Text="View" OnClick="viewStads" CssClass="btn" ></asp:Button>

                    <br />
                
                    <asp:Table ID="table2"  runat="server">
                         <asp:TableHeaderRow CssClass="header" style="background-color:darkslategrey;">
                             <asp:TableCell CssClass="cell">Name</asp:TableCell>
                             <asp:TableCell CssClass="cell">Location</asp:TableCell>
                             <asp:TableCell CssClass="cell">Capacity</asp:TableCell>
                         </asp:TableHeaderRow>
                    </asp:Table>
                </div>

                <div class="addreq">
                    <h2 style="text-align:center;margin-top:0;">Send host request</h2>

                    <div style="width:220px">
                        <label>Stadium name</label>
                        <asp:TextBox ID="stadname" runat="server" CssClass="txtbox"></asp:TextBox> 
                    </div>
                    <div  style="width:220px">
                        <label>Match start time</label>
                        <asp:TextBox ID="date" runat="server" textmode="DateTimeLocal" CssClass="txtbox"></asp:TextBox> 
                    </div>

                    <asp:Button runat="server" Text="Send" OnClick="sentHostReq" CssClass="btn" style="margin-top:10px"></asp:Button>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
