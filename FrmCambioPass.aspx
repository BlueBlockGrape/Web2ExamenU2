<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmCambioPass.aspx.cs" Inherits="examenU2Aaron.FrmCambioPass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Cambio Pass</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <div class="container p-3 mb-2">
        <div style="text-align: center;">
            <h1>CAMBIO DE CONTRASEÑA</h1>
        </div>
    <form id="form1" runat="server" novalidate>
        <div id="divMensaje" class="alert alert-danger" runat="server">
                Ha ocurrido un error del lado del servidor
            </div>
            <div id="divMsg" class="alert alert-danger" style="display:none;">
                Ha ocurrido un error por el catch de JS
            </div>

        <div class="form-row justify-content-left">
            <div class="col-md-2 mb-2" align="right" >
              <label for="txtNombreUs"><strong>Usuario a Editar</strong></label>
            </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtUsuario" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

        <div class="form-row justify-content-left">
            <div class="col-md-2 mb-2" align="right" >
              <label for="txtNewContrasena"><strong>Nueva Contraseña</strong></label>
            </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtNewContrasena" TextMode="Password" runat="server" autocomplete="off" class="form-control" required></asp:TextBox>
                    <div class="invalid-feedback">
                        La contraseña no tiene el formato correcto o no se ha introducido
                    </div>
                </div>
            </div>

        <div class="form-row justify-content-left">
            <div class="col-md-2 mb-2" align="right" >
              <label for="txtRNewContraseña"><strong>Repetir Contraseña</strong></label>
            </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtRNewContraseña" TextMode="Password" runat="server" autocomplete="off" class="form-control" required></asp:TextBox>
                <div class="invalid-feedback">
                        Las contraseñas no coinciden o no se ha introducido
                    </div>
                </div>
            </div>

            <div class="form-row justify-content-center">
                <div class="col-md-6 mb-2 mt-2">
                    <asp:Button ID="btnancelar" class="btn btn-secondary" runat="server" Text="Cancelar" OnClick="btnancelar_Click" />
                    <asp:Button ID="btnCambio" runat="server" Text="Confirmar" class="btn btn-primary" OnClick="btnCambio_Click" />
                </div>
            </div>

    </form>
    </div>

    <script src="js/jquery-3.4.1.js"></script>
    <script src="js/bootstrap.js"></script>
     <script>
         window.addEventListener('load', function () {
             var btn = document.getElementById("btnCambio");
             btn.addEventListener('click', function (evento) {

                 var txtNewContrasena1 = document.getElementById("txtNewContrasena");
                 var txtRNewContraseña1 = document.getElementById("txtRNewContraseña");


                 try {

                     txtNewContrasena1.classList.remove('is-valid', 'is-invalid');
                     txtRNewContraseña1.classList.remove('is-valid', 'is-invalid');

                     var txtNewContrasena2 = txtNewContrasena1.value.trim();
                     var txtRNewContraseña2 = txtRNewContraseña1.value.trim();


                     if (txtNewContrasena2 == "" || txtRNewContraseña2 == "") {

                         if (txtNewContrasena2 == "") {
                             txtNewContrasena1.classList.add('is-invalid');
                         } else {
                             txtNewContrasena1.classList.add('is-valid');
                         }

                         if (txtRNewContraseña2 == "") {
                             txtRNewContraseña1.classList.add('is-invalid');
                         } else {
                             txtRNewContraseña1.classList.add('is-valid');
                         }

                         evento.preventDefault();

                     } else {

                         var vrpassword = new RegExp(/^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{6,}$/, 'g'); ///^(?=.\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$^&*])[0-9a-zA-Z!@#$%^&*]{8,}$/g
                         if (vrpassword.test(txtNewContrasena2)) {
                             txtNewContrasena1.classList.add('is-valid');
                         } else {
                             txtNewContrasena1.classList.add('is-invalid');
                             evento.preventDefault();
                         }


                         if (txtRNewContraseña2 != txtNewContrasena2) {
                             txtRNewContraseña1.classList.add('is-invalid');
                             evento.preventDefault();
                         } else {
                             txtRNewContraseña1.classList.add('is-valid');
                         }

                     }
                 } catch (e) {
                     document.getElementById('divMsg').style.display = 'block';
                     evento.preventDefault();
                 }

             });
        });
     </script>
</body>
</html>
