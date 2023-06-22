<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="WebApplication1.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
    <style>
         body{
            margin:0;
            background-color:#111;
            font-family:sans-serif;
        }
         *{
             box-sizing:border-box;
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
            padding:35px;
            width:100%;
            max-width:600px;
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
            height:35px;
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
        span{
            font-size:13px;
        }
        input[type='radio'] { 
             transform: scale(1.5); 
             margin-right:5px;
        }

        #field{
            display:flex;
            justify-content:center;

            align-items:center;
            flex-wrap:wrap;
            flex-direction:column;
            gap:10px;
        }
        #adressField , #birthDateField , #clubField , #nationalIdField , #phoneField , #stadiumField {display:none;}
        .no{
           width:220px;
           display:flex;
           flex-direction:column;
        }

    </style>
</head>
<body>
    <div class="cont">
        <div class="wrap">
            <form id="form1" runat="server" autocomplete="off">
        
                <h1 style="margin-top:-50px; font-size:50px">Registration</h1>
                <asp:RadioButtonList ID="type" runat="server"  RepeatColumns="2" CellSpacing="10" CssClass="radio" OnSelectedIndexChanged="onTypeChanged" AutoPostBack="true">
                    <asp:ListItem Text="Association Manager" Selected="True"/>
                    <asp:ListItem Text="Club Representative" /> 
                    <asp:ListItem Text="Stadium Manager" />
                    <asp:ListItem Text="Fan" />
                </asp:RadioButtonList>
                <div id="field" runat="server">
                    <div class="no">
                        <span>Name</span>
                        <asp:TextBox ID="name" runat="server" placeholder="name" CssClass="txtbox"></asp:TextBox>
                    </div>
                    <div class="no">
                        <span>Username</span>
                        <asp:TextBox ID="username" runat="server" placeholder="username" CssClass="txtbox"></asp:TextBox>
                    </div>
                    <div class="no">
                        <span>Password</span>
                        <asp:TextBox ID="password" runat="server" placeholder="password" CssClass="txtbox" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="no" id="stadiumField" runat="server">
                        <span>Stadium</span>
                        <asp:TextBox ID="stadium" runat="server" placeholder="stadium" CssClass="txtbox"></asp:TextBox>
                    </div>
                    <div class="no" id="clubField" runat="server">
                        <span>Club</span>
                        <asp:TextBox ID="club" runat="server" placeholder="club" CssClass="txtbox"></asp:TextBox>
                    </div>
                    <div class="no" id="nationalIdField" runat="server">
                        <span>National ID</span>
                        <asp:TextBox ID="nationalID" runat="server" placeholder="national ID" CssClass="txtbox" TextMode="Number"></asp:TextBox>
                    </div>
                    <div class="no" id="phoneField" runat="server">
                        <span>Phone number</span>
                        <asp:TextBox ID="phone" runat="server" placeholder="phone number" CssClass="txtbox" TextMode="Number"></asp:TextBox>
                    </div>
                    <div class="no" id="birthDateField" runat="server">
                        <span>Birth date</span>
                        <asp:TextBox ID="birthDate" runat="server" CssClass="txtbox" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="no" id="adressField" runat="server">
                        <span>Adress</span>
                        <asp:TextBox ID="adress" runat="server" placeholder="adress" CssClass="txtbox"></asp:TextBox>
                    </div>

                </div>
                <asp:Button runat="server" Text="Register" CssClass="btn" OnClick="MultiTask"/>
                <span id="msg" runat="server"></span>
        
            </form>
        </div>
    </div>
</body>
</html>
