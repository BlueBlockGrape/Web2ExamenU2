<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmRegistroUsuario.aspx.cs" Inherits="examenU2Aaron.FrmRegistroUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Registrar y Editar</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>

    <div class="container p-3 mb-2">
        <div style="text-align: center;">
            <h1>INSERTAR Y EDITAR USUARIOS</h1>
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
                  <label for="txtNombreUs"><strong>NOMBRE</strong></label>
                </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtNombreUs" runat="server" autocomplete="off" class="form-control" MaxLength="30" required></asp:TextBox>
                    <div class="invalid-feedback">
                            El nombre introducido no es valido o no se ha introducido
                    </div>
                </div>
            </div>

            <div class="form-row justify-content-left">
                <div class="col-md-2 mb-2" align="right" >
                  <label for="txtPrimerApellidoUs"><strong>PRIMER APELLIDO</strong></label>
                </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtPrimerApellidoUs" runat="server" autocomplete="off" class="form-control" MaxLength="40" required></asp:TextBox>
                    <div class="invalid-feedback">
                        El apellido introducido no es valido o no se ha introducido
                    </div>
                </div>
            </div>

            <div class="form-row justify-content-left">
                <div class="col-md-2 mb-2" align="right" >
                  <label for="txtSegundoApellidoUs"><strong>SEGUNDO APELLIDO</strong></label>
                </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtSegundoApellidoUs" runat="server" autocomplete="off" class="form-control" MaxLength="40"></asp:TextBox>
                </div>
            </div>

            <div class="form-row justify-content-left">
                <div class="col-md-2 mb-2" align="right" >
                  <label for="txtEmailUs"><strong>EMAIL</strong></label>
                </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtEmailUs" TextMode="Email" runat="server" autocomplete="off" class="form-control" MaxLength="60" required></asp:TextBox>
                    <div class="invalid-feedback">
                    El email introducido no es valido o no se ha introducido
                    </div>
                </div>
            </div>

             <%
                 //verificar porque ya esta del lado del servidor
                 int edit = int.Parse(Session["editar"].ToString());
                 if (edit == -1)
                 {
                    %> 

            <div class="form-row justify-content-left">
                <div class="col-md-2 mb-2" align="right" >
                  <label for="txtContrasenaUs"><strong>CONTRASEÑA</strong></label>
                </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtContrasenaUs" TextMode="Password" runat="server" autocomplete="off" class="form-control" required></asp:TextBox>
                    <div class="invalid-feedback">
                       la contraseña no es valida o no se ha introducido 
                    </div>
                </div>
            </div>

             <div class="form-row justify-content-left">
                <div class="col-md-2 mb-2" align="right" >
                  <label for="txtRepetirContrasenaUs"><strong>REPIETIR CONTRASEÑA</strong></label>
                </div>
                <div class="col-md-6 mb-2">
                    <asp:TextBox ID="txtRepetirContrasenaUs" TextMode="Password" runat="server" autocomplete="off" class="form-control" required></asp:TextBox>
                    <div class="invalid-feedback">
                    La contraseña no coincide o no se ha introducido
                    </div>
                </div>
            </div>
            <% } %>

            <div class="form-row justify-content-left">
            <div class="col-md-2 mb-2" align="right" >
                
              <label id="lblTipo" for="ddlTipoUs"><strong>TIPO</strong></label>
            </div>
            <div class="col-md-6 mb-4">
                <asp:DropDownList ID="ddlTipoUs" runat="server"></asp:DropDownList>
                </div>
            </div>

            <div class="form-row justify-content-left">
            <div class="col-md-2 mb-2" align="right" >
              <label id="lblCarrera" for="ddlCarrerasUs"><strong>CARRERA</strong></label>
            </div>
                <div class="col-md-6 mb-4">
                    <asp:DropDownList ID="ddlCarrerasUs" runat="server"></asp:DropDownList>
                </div>
            </div>

            <div class="form-row justify-content-center">
                <div class="col-md-6 mb-2 mt-2">
                    <asp:Button ID="cancelar" runat="server" Text="Cancelar" class="btn btn-secondary" OnClick="cancelar_Click" />
                    <asp:Button ID="btnregistrarUs" class="btn btn-primary" runat="server" Text="Confirmar" OnClick="registrarUs_Click" />
                </div>
            </div>

        </form>
    </div>

    <script src="js/jquery-3.4.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <script>
        window.addEventListener('load', function () {
            var btn = document.getElementById("btnregistrarUs");
            btn.addEventListener('click', function (evento) {


                if (document.getElementById("txtContrasenaUs") == null) {


                    //Obtener los controles a validar en el formulario
                    var txtNombreUs1 = document.getElementById("txtNombreUs");
                    var txtPrimerApellidoUs1 = document.getElementById("txtPrimerApellidoUs");
                    var txtEmailUs1 = document.getElementById("txtEmailUs");
                    // var txtContrasenaUs1 = document.getElementById("txtContrasenaUs");
                    //var txtRepetirContrasenaUs1 = document.getElementById("txtRepetirContrasenaUs");


                    try {
                        //Limpiar los estilos de validación, para que no se muestren los errores pasados

                        txtNombreUs1.classList.remove('is-valid', 'is-invalid');
                        txtPrimerApellidoUs1.classList.remove('is-valid', 'is-invalid');
                        txtEmailUs1.classList.remove('is-valid', 'is-invalid');
                        //  txtContrasenaUs1.classList.remove('is-valid', 'is-invalid');
                        // txtRepetirContrasenaUs1.classList.remove('is-valid', 'is-invalid');

                        //Obtener los valores ingresados en los campos del formulario
                        var txtNombreUs2 = txtNombreUs1.value.trim();
                        var txtPrimerApellidoUs2 = txtPrimerApellidoUs1.value.trim();
                        var txtEmailUs2 = txtEmailUs1.value.trim();
                        //   var txtContrasenaUs2 = txtContrasenaUs1.value.trim();
                        //  var txtRepetirContrasenaUs2 = txtRepetirContrasenaUs1.value.trim();


                        //Verificar si se ha ingresado datos en ellos
                        if (txtNombreUs2 == "" || txtPrimerApellidoUs2 == "" || txtEmailUs2 == "" || txtContrasenaUs2 == "" || txtRepetirContrasenaUs2 == "") {
                            if (txtNombreUs2 == "") {
                                txtNombreUs1.classList.add('is-invalid');
                            } else {
                                txtNombreUs1.classList.add('is-valid');
                            }

                            if (txtPrimerApellidoUs2 == "") {
                                txtPrimerApellidoUs1.classList.add('is-invalid');
                            } else {
                                txtPrimerApellidoUs1.classList.add('is-valid');
                            }

                            if (txtEmailUs2 == "") {
                                txtEmailUs1.classList.add('is-invalid');
                            } else {
                                txtEmailUs1.classList.add('is-valid');
                            }

                            /*     if (txtContrasenaUs2 == "") {
                                     txtContrasenaUs1.classList.add('is-invalid');
                                 } else {
                                     txtContrasenaUs1.classList.add('is-valid');
                                 }

                                 if (txtRepetirContrasenaUs2 == "") {
                                     txtRepetirContrasenaUs1.classList.add('is-invalid');
                                 } else {
                                     txtRepetirContrasenaUs1.classList.add('is-valid');
                                 }*/

                            //Cancelar el submit
                            evento.preventDefault();
                        } else {

                            //Verificar validaciones de los campos (correo)

                            var emailExp = new RegExp(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/);
                            if (emailExp.test(txtEmailUs2)) {
                                txtEmailUs1.classList.add('is-valid');
                            } else {
                                txtEmailUs1.classList.add('is-invalid');
                                evento.preventDefault();
                            }

                        }
                    } catch (e) {
                        document.getElementById('divMsg').style.display = 'block';
                        evento.preventDefault();
                    }


                } else {



                    //Obtener los controles a validar en el formulario
                    var txtNombreUs1 = document.getElementById("txtNombreUs");
                    var txtPrimerApellidoUs1 = document.getElementById("txtPrimerApellidoUs");
                    var txtEmailUs1 = document.getElementById("txtEmailUs");
                    var txtContrasenaUs1 = document.getElementById("txtContrasenaUs");
                    var txtRepetirContrasenaUs1 = document.getElementById("txtRepetirContrasenaUs");


                    try {
                        //Limpiar los estilos de validación, para que no se muestren los errores pasados

                        txtNombreUs1.classList.remove('is-valid', 'is-invalid');
                        txtPrimerApellidoUs1.classList.remove('is-valid', 'is-invalid');
                        txtEmailUs1.classList.remove('is-valid', 'is-invalid');
                        txtContrasenaUs1.classList.remove('is-valid', 'is-invalid');
                        txtRepetirContrasenaUs1.classList.remove('is-valid', 'is-invalid');

                        //Obtener los valores ingresados en los campos del formulario
                        var txtNombreUs2 = txtNombreUs1.value.trim();
                        var txtPrimerApellidoUs2 = txtPrimerApellidoUs1.value.trim();
                        var txtEmailUs2 = txtEmailUs1.value.trim();
                        var txtContrasenaUs2 = txtContrasenaUs1.value.trim();
                        var txtRepetirContrasenaUs2 = txtRepetirContrasenaUs1.value.trim();


                        //Verificar si se ha ingresado datos en ellos
                        if (txtNombreUs2 == "" || txtPrimerApellidoUs2 == "" || txtEmailUs2 == "" || txtContrasenaUs2 == "" || txtRepetirContrasenaUs2 == "") {
                            if (txtNombreUs2 == "") {
                                txtNombreUs1.classList.add('is-invalid');
                            } else {
                                txtNombreUs1.classList.add('is-valid');
                            }

                            if (txtPrimerApellidoUs2 == "") {
                                txtPrimerApellidoUs1.classList.add('is-invalid');
                            } else {
                                txtPrimerApellidoUs1.classList.add('is-valid');
                            }

                            if (txtEmailUs2 == "") {
                                txtEmailUs1.classList.add('is-invalid');
                            } else {
                                txtEmailUs1.classList.add('is-valid');
                            }

                            if (txtContrasenaUs2 == "") {
                                txtContrasenaUs1.classList.add('is-invalid');
                            } else {
                                txtContrasenaUs1.classList.add('is-valid');
                            }

                            if (txtRepetirContrasenaUs2 == "") {
                                txtRepetirContrasenaUs1.classList.add('is-invalid');
                            } else {
                                txtRepetirContrasenaUs1.classList.add('is-valid');
                            }

                            //Cancelar el submit
                            evento.preventDefault();
                        } else {

                            //Verificar validaciones de los campos  (Correo y contraseña)

                            var cont = 0;

                            if (txtContrasenaUs2 != txtRepetirContrasenaUs2) {
                                txtRepetirContrasenaUs1.classList.add('is-invalid');
                                cont++;
                            } else {
                                txtRepetirContrasenaUs1.classList.add('is-valid');
                            }

                            var vrpassword = new RegExp(/^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{6,}$/, 'g'); ///^(?=.\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$^&*])[0-9a-zA-Z!@#$%^&*]{8,}$/g
                            if (vrpassword.test(txtContrasenaUs2)) {
                                txtContrasenaUs1.classList.add('is-valid');
                            } else {
                                txtContrasenaUs1.classList.add('is-invalid');
                                cont++;
                            }

                            var emailExp = new RegExp(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/);
                            if (emailExp.test(txtEmailUs2)) {
                                txtEmailUs1.classList.add('is-valid');
                            } else {
                                txtEmailUs1.classList.add('is-invalid');
                                cont++;
                            }

                            if (cont > 0) {
                                evento.preventDefault();
                            }

                        }
                    } catch (e) {
                        document.getElementById('divMsg').style.display = 'block';
                        evento.preventDefault();
                    }
                }
            });
        });         

    </script>

</body>
</html>
