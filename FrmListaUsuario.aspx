<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmListaUsuario.aspx.cs" Inherits="examenU2Aaron.FrmListaUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Lsita de Usuarios</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <div class="container p-3 mb-2">
    
        
        <form runat="server">


         <!-------------------INICIA MODAL PARA ELIMINAR USUARIO ---------------------->
     <div class="modal" id="mdlConfirmar" tabindex="-1" role="dialog">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">CONFIRMACION DE ELIMINACIÓN DE REGISTRO</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <p>Una vez eliminado el registro no se puede reponer <br />
                    ¿Estás seguro que deseas eliminarlo?</p>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <asp:Button ID="btnConfirmarEliminar" CssClass="btn btn-danger" OnClick="btnConfirmarEliminar_Click" runat="server" Text="Eliminar" />
              </div>
            </div>
          </div>
     </div>
    <!--Termina modal -->

        <asp:HiddenField ID="IdUsuario" runat="server" />
        <div style="text-align: center;">
            <h1>Lista de Usuarios</h1>
        </div>
        <div class="row justify-content-center my-2">
            <asp:Button ID="btnAgregarUs" CssClass="btn btn-primary" runat="server" Text="AGREGAR" OnClick="btnAgregarUs_Click" />
        </div>

        <asp:GridView ID="grvUsuarios" CssClass="table table-bordered table-striped" runat="server" OnRowCommand="grvUsuarios_RowCommand" DataKeyNames="id">

            <Columns>
                <asp:BoundField DataField="id" HeaderText="Clave" />
                <asp:BoundField DataField="nombreCompleto" HeaderText="Nombre Usuario" />
                <asp:BoundField DataField="email" HeaderText="Correo"/>
                <asp:BoundField DataField="carrera_usuario" HeaderText="Carrera"/>
                <asp:BoundField DataField="tipo_usuario" HeaderText="Tipo"/>
                <asp:ButtonField CommandName="Cambiar" ButtonType="Button" ControlStyle-CssClass="btn btn-info" Text="Cambiar Contraseña"/>
                <asp:ButtonField CommandName="Editar" ButtonType="Button" ControlStyle-CssClass="btn btn-primary" Text="Editar"/>
                <asp:ButtonField CommandName="Eliminar"  ButtonType="Button" ControlStyle-CssClass="btn btn-danger" Text="Eliminar"/>
            </Columns>




        </asp:GridView>


    </form>
    </div>



    <script src="js/jquery-3.4.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/datatables.js"></script>
    <script>
    $(document).ready( function () {
        let tabla = $('#contenido_grvUsuarios');
        let fila = $(tabla).find("tbody tr:first").clone();
        $(tabla).find("tbody tr:first").remove();
        let encabezado = $("<thead/>").append(fila);
        $(tabla).children('tbody').before(encabezado);
        $('#contenido_grvUsuarios').DataTable();
        
    });
    </script>

</body>
</html>
