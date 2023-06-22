<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fan.aspx.cs" Inherits="WebApplication1.fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fan</title>
    <style>
        body{
            font-family:sans-serif;
            margin:0;
            background-color:#111;
        }
        *{
            box-sizing:border-box;
        }
        .cont{
            display:flex;
            justify-content:center;
            flex-wrap:wrap;
            padding:50px;
            gap:20px
        }
        .view-matches{
            padding:35px;
            background-color:#eee;
            border-radius:10px;
            display:flex;
            align-items:center;
            flex-direction:column;
            gap:10px;
        }
        #table1{
            width:100%;
        }
        .row {background-color: #ddd;}

        .cell{ 
           padding:10px;
        }
        .header{
            background-color:darkslategray;
            color: white;
        }
        .puchase{
            background-color:#eee;
            padding:35px 55px;
            border-radius:15px;
            display:flex;
            flex-direction:column;
            align-items:center;
            gap:10px;
        }
        h1{
            text-align:center;
            color:white;
            font-size:50px;
            margin:10px;
        }
         .txtbox{
            width:220px;
            height:37px;
            border:1px solid #ddd;
            padding:10px;
            border-radius:15px;
            font-size:16px;
        }
        label{
            font-size:14px
        }
        .btn{
            padding:8px 20px;
            background-color: brown;
            border-radius:10px;
            color:white;
            border:none;
            cursor:pointer;
            transition:.3s;
            font-size:14px;
            margin-top:5px;
            margin-bottom:10px;
        }
        .btn:hover{
            box-shadow:0px 0px 5px -2px #666
        }
        h3{
            margin-top:0;
            margin-bottom:15px;
            font-size:20px;
        }
        .scroll{
            max-height:178px;
            overflow:scroll;
            display:none;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>FAN</h1>
        <div class="cont" id="cont">
            
            <div class="view-matches">
                <h3>View available matches to atttend</h3>
                <div style="width:220px">
                    <label>Starting</label>
                    <asp:TextBox ID="startingfrom" runat="server" textmode="DateTimeLocal" CssClass="txtbox"></asp:TextBox> 
                </div>
                <asp:Button runat="server" Text="View" OnClick="viewMatches" CssClass="btn"></asp:Button>
                
                <div class="scroll" runat="server" id="scroll">
                    <asp:Table ID="table1"  runat="server">
                         <asp:TableHeaderRow CssClass="header">
                             <asp:TableCell CssClass="cell">Host</asp:TableCell>
                             <asp:TableCell CssClass="cell">Guest</asp:TableCell>
                             <asp:TableCell CssClass="cell">Stadium</asp:TableCell>
                             <asp:TableCell CssClass="cell">Location</asp:TableCell>
                             <asp:TableCell CssClass="cell">Start time</asp:TableCell>
                         </asp:TableHeaderRow>
                    </asp:Table>
                </div>
                
            </div>
           
            <div class="puchase">
                <h3> Purchase a ticket</h3>
                <div style="width:220px">
                    <label>Host name</label>
                    <asp:TextBox ID="hostName" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>
                <div style="width:220px">
                    <label>Guest name</label>
                    <asp:TextBox ID="guestName" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>
                <div style="width:220px">
                    <label>Start time</label>
                    <asp:TextBox ID="startTime" runat="server" textmode="DateTimeLocal" CssClass="txtbox"></asp:TextBox>
                </div>
                <asp:Button runat="server" Text="Purchase" OnClick="PurchaseTicket" CssClass="btn"></asp:Button>
            </div>
        </div>
    </form>
</body>
</html>
