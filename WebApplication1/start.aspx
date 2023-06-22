<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="start.aspx.cs" Inherits="WebApplication1.start" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Landing page</title>
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
            font-size:60px;
            margin:0;
        }

        .btns{
            display:flex;
            justify-content:center;
            align-items:center;
            margin-top:60px;
            width:100%;
            max-width:100%;
            gap:10px;

        }

        .wrap{
            background-color:#eee;
            width:100%;
            max-width:600px;
            margin:150px auto;
            padding:70px;
            border-radius:25px;
        }

        .btn{
            padding:17px 43px;
            background-color:darkslategray;
            font-size: 25px;
            border-radius:15px;
            cursor:pointer;
            border:none;
            transition:.3s;
            color:white;

        }
        .btn:hover{
            background-color:#333;
            color:white;
        }
        
    </style>
</head>
<body>
    <div class="wrap">
        <h1>Hello there!</h1>
    
        <form id="form1" runat="server">
            <div class="btns">
                <asp:Button runat="server" Text="Sign in" CssClass="btn" OnClick="login"/>
                <asp:Button runat="server" Text="Register"  CssClass="btn" OnClick="register"/>
            </div>
        </form>
    </div>
</body>
</html>
