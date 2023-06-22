<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="systemAdmin.aspx.cs" Inherits="WebApplication1.systemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin</title>
    <style>
        *{
            box-sizing:border-box;
        }
        body{
            margin:0;
            padding:0;
            font-family:sans-serif;
            background-color:#111;
        }
        .wrap{
            display:flex;
            flex-wrap:wrap;
            gap:20px;
            justify-content:center;
            padding:20px 140px;
        }

        .cont{
            width:300px;
            border-radius:15px;
            background-color:#eee;
            padding:30px;
            margin:0;
            display:flex;
            align-items:center;
            gap:10px;
            flex-direction:column;
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
        }
        .btn:hover{
            box-shadow:0px 0px 5px -2px #666
        }
        h1{
            text-align:center;
            font-size:55px;
            margin:10px 0 0;
            color:white;
        }
        h3{
            margin-top:0;
            font-size:20px;
        }
    </style>
</head>
<body>
    <h1>ADMIN</h1>
    
    <form id="form1" runat="server">
        <div class="wrap">

            <div class="cont">
            <h3>Delete club </h3>
            <div style="width:220px">
                <label>Name</label>
                <asp:TextBox ID="dName" runat="server" CssClass="txtbox"></asp:TextBox>
            </div>
            <asp:Button runat="server" Text="Delete" OnClick="deleteClub" CssClass="btn"></asp:Button>

        </div>
        
        <div class="cont">
            <h3>Delete stadium </h3>

            <div style="width:220px">
                <label>Name</label>
                <asp:TextBox ID="sdName" runat="server" CssClass="txtbox"></asp:TextBox>
            </div>
       
            <asp:Button runat="server" Text="Delete" OnClick="deleteStadium" CssClass="btn"></asp:Button>
        </div>
       
        <div class="cont">
            <h3>Block fan</h3>

            <div style="width:220px">
                <label>National ID</label>
                <asp:TextBox ID="natID" runat="server" CssClass="txtbox"></asp:TextBox>
            </div>
            <asp:Button runat="server" Text="Block" OnClick="blockFan" CssClass="btn"></asp:Button>
        </div>


            <div class="cont">
                <h3>Add a new club </h3>
                <div style="width:220px">
                    <label>Name</label>
                    <asp:TextBox ID="aName" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>

                <div style="width:220px">
                    <label>Location</label>
                    <asp:TextBox ID="Location" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>

                <asp:Button runat="server" Text="Add" OnClick="addClub" CssClass="btn" style="background-color:#04AA6D"></asp:Button>
            </div>

        
            <div class="cont">
                <h3>Add new stadium</h3>
            
                <div style="width:220px">
                    <label>Name</label>
                    <asp:TextBox ID="sName" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>
            
                <div style="width:220px">
                    <label>Location</label>
                    <asp:TextBox ID="sLocation" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>

                <div style="width:220px">
                    <label>Capacity</label>
                    <asp:TextBox ID="sCapacity" runat="server" CssClass="txtbox"></asp:TextBox>
                </div>
                <asp:Button runat="server" Text="Add" OnClick="addStadium" CssClass="btn" style="background-color:#04AA6D"></asp:Button>
            </div>
        
        </div> 
    </form>
</body>
</html>
