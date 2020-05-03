using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace examenU2Aaron
{
    public partial class FrmListaUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["editar"] = -1;
            if (!IsPostBack)
            {
                grvUsuarios.AutoGenerateColumns = false;
                CargarDatos();
            }
        }

        

        protected void btnAgregarUs_Click(object sender, EventArgs e)
        {
            Response.Redirect("FrmRegistroUsuario.aspx");
        }

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            XDocument docusuario;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"xml\baseUsuarios.xml";
            docusuario = XDocument.Load(path);
            XElement element = docusuario.Descendants("Usuario").FirstOrDefault(u => u.Element("id").Value == IdUsuario.Value);
            if (element != null)
            {
                element.Remove();
                docusuario.Save(path);

               // grvUsuarios.AutoGenerateColumns = false;
                CargarDatos();

            }


        }


        protected void grvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                Dictionary<String, String> info = new Dictionary<string, string>();
                info.Add("id", grvUsuarios.Rows[int.Parse(e.CommandArgument.ToString())].Cells[0].Text);
                enviar("FrmRegistroUsuario.aspx", info);
            }
            else if (e.CommandName == "Eliminar")
            {
                IdUsuario.Value = grvUsuarios.Rows[int.Parse(e.CommandArgument.ToString())].Cells[0].Text;
                Response.Write("<script>" +
                    "window.addEventListener('load', function () {$('#mdlConfirmar').modal('show');});</script>");
            }
            else if (e.CommandName == "Cambiar")
            {
                Dictionary<String, String> info = new Dictionary<string, string>();
                info.Add("idUsuario1", grvUsuarios.Rows[int.Parse(e.CommandArgument.ToString())].Cells[0].Text);
                enviar("FrmCambioPass.aspx", info);
            }

        }


        XDocument docusuario;
        string path = AppDomain.CurrentDomain.BaseDirectory + @"xml\baseUsuarios.xml";
        public void CargarDatos()
        {
            docusuario = XDocument.Load(path);
            var contenido = docusuario.Descendants("Usuario").Select(user => new
            {

                id = user.Element("id").Value,
                nombre = user.Element("nombre").Value,
                primerApellido = user.Element("primerApellido").Value,
                segundoApellido = user.Element("segundoApellido").Value,
                email = user.Element("email").Value,
                carrera_usuario = user.Element("carrera_usuario").Value,
                tipo_usuario = user.Element("tipo_usuario").Value,
                nombreCompleto = string.Format("{0} {1} {2}", user.Element("nombre").Value, user.Element("primerApellido").Value, user.Element("segundoApellido").Value)
            }).OrderBy(user => user.id);

            
            grvUsuarios.DataSource = contenido;
            grvUsuarios.DataBind();


        }


        public void enviar(String url, Dictionary<String, String> valores)
        {
            Response.Clear();
            Response.Write("<html><head>");
            Response.Write("</head><body onload=\"document.frm.submit()\">");
            Response.Write(string.Format("<form name=\"frm\" method=\"post\" action=\"{0}\" >", url));
            foreach (KeyValuePair<String, String> item in valores)
            {
                Response.Write(string.Format("<input name=\"{0}\" type=\"hidden\" value=\"{1}\">", item.Key, item.Value));
            }
            Response.Write("</form>");
            Response.Write("</body></html>");
            Response.End();

        }


    }
}