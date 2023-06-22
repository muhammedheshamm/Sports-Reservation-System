<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication1.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        body{
            margin:0;
            background-color:#111;
            font-family:sans-serif;
        }
        .cont{
            display:flex;
            justify-content:center;
            align-items:center;
            width:100vw;
            height:100vh;
        }
        .wrap{
            display:flex;
            justify-content:center;
            align-items:center;
            padding:25px;
            width:100%;
            max-width:450px;
            height:350px;
            border-radius:35px;
            background-color:#eee;
        }
        #form1{
            display:flex;
            justify-content:center;
            align-items:center;
            flex-direction:column;
            gap:20px;
        }
        .txtbox{
            width:220px;
            height:22px;
            border:1px solid #ddd;
            padding:10px;
            border-radius:15px;
            font-size:16px;
        }

        .btn{
            padding:13px 25px;
            background-color: #04AA6D;
            border-radius:10px;
            color:white;
            border:none;
            cursor:pointer;
            transition:.3s;
            font-size:14px
        }
        .btn:hover{
            box-shadow:0px 0px 5px -2px #666
        }
    </style>
    <title>login</title>
</head>
<body>
    <div class="cont">
        <div class="wrap">
            <form id="form1" runat="server">
        
                <h1 style="margin-top:-50px; font-size:50px">Sign in</h1>

                <asp:TextBox ID="username" runat="server" placeholder="username" CssClass="txtbox"></asp:TextBox>
                <asp:TextBox ID="password" runat="server" placeholder="password" CssClass="txtbox" TextMode="Password"></asp:TextBox>
                <asp:Button ID="loginnn" runat="server" Text="LOGIN" OnClick="loginn" CssClass="btn"/>
                <span id="msg" runat="server"></span>
        
            </form>
        </div>
    </div>
</body>
</html>
