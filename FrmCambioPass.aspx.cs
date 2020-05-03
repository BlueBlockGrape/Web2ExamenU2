using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.Text.RegularExpressions;


namespace examenU2Aaron
{
    public partial class FrmCambioPass : System.Web.UI.Page
    {
        string z;
        protected void Page_Load(object sender, EventArgs e)
        {

            divMensaje.Visible = false;
            txtUsuario.ReadOnly = true;
            if (!IsPostBack)
            {
                if (Request["IdUsuario1"] != null)
                {
                    Session["editar"] = int.Parse(Request["IdUsuario1"].ToString());

                    txtUsuario.Text = getOne(Request["IdUsuario1"].ToString());
                }


            }


        }


        protected void btnCambio_Click(object sender, EventArgs e)
        {
            if (int.Parse(Session["editar"].ToString()) >= 0)
            {
               // var regex = new Regex(@"^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A - Z])(?=.*[a - z])\S{ 6,}$");
                Regex regex = new Regex(@"^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{6,}$");
                bool c = regex.IsMatch(txtNewContrasena.Text.Trim());
                if ((txtNewContrasena.Text.Trim() != "" && txtRNewContraseña.Text.Trim() != "") && 
                    (txtNewContrasena.Text.Trim() == txtRNewContraseña.Text.Trim()) && (c))
                {
                    XDocument docusuario;
                    string path = AppDomain.CurrentDomain.BaseDirectory + @"xml\baseUsuarios.xml";
                    docusuario = XDocument.Load(path);
                    string zz = Session["editar"].ToString();
                    XElement element = docusuario.Descendants("Usuario").FirstOrDefault(u => u.Element("id").Value == zz);
                    if (element != null)
                    {

                        //Encriptacion de contraseña con el sha 1
                        var sh = new SHA1CryptoServiceProvider();
                        var cadena = Encoding.ASCII.GetBytes(txtNewContrasena.Text);
                        var modificado = sh.ComputeHash(cadena);
                        var final = BitConverter.ToString(modificado).Replace("-", "").ToLower();

                        string cad = final.ToString();


                        element.Element("contrasena").Value = cad;
                        docusuario.Save(path);
                        Response.Redirect("FrmListaUsuario.aspx");

                    }

                }
                else
                {
                    divMensaje.Visible = true;
                }

            }

        }

        protected void btnancelar_Click(object sender, EventArgs e)
        {
            Session["editar"] = -1;
            Response.Redirect("FrmListaUsuario.aspx");
        }


        

        protected string getOne(string idUser)
        {
            XDocument docusuario;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"xml\baseUsuarios.xml";
            docusuario = XDocument.Load(path);
            string cadena = "";
            XElement usuar = docusuario.Descendants("Usuario").FirstOrDefault(p => p.Element("id").Value == idUser);
            if (usuar != null)
            {
                cadena = usuar.Element("nombre").Value+" "+ usuar.Element("primerApellido").Value+" "+ usuar.Element("segundoApellido").Value;

            }
            return cadena;
        }





    }
}
