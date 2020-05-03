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
    public partial class FrmRegistroUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            divMensaje.Visible = false;
            if (!IsPostBack)
            {
                               

                CargarCarreras();

                ddlTipoUs.Items.Insert(0, "Docente");
                ddlTipoUs.Items.Insert(1, "Coordinador");
                ddlTipoUs.Items.Insert(2, "Encargado");

                if (Request["id"] != null)
                {
                    Session["editar"] = int.Parse(Request["id"].ToString());
                    CargarDatos(Request["id"].ToString());
                }





            }
        }


        protected void cancelar_Click(object sender, EventArgs e)
        {
            Session["editar"] = -1;
            Response.Redirect("FrmListaUsuario.aspx");
        }

        protected void registrarUs_Click(object sender, EventArgs e)
        {

            if (int.Parse(Session["editar"].ToString()) >= 0)
            {

                Regex regex = new Regex(@"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$");
                bool c = regex.IsMatch(txtEmailUs.Text.Trim());

                if ((txtNombreUs.Text.Trim() != "" && txtPrimerApellidoUs.Text.Trim() != "" &&
                                        txtEmailUs.Text.Trim() != "") && (c))
                {
                    XDocument docusuario;
                    string path = AppDomain.CurrentDomain.BaseDirectory + @"xml\baseUsuarios.xml";
                    docusuario = XDocument.Load(path);
                    string zz = Session["editar"].ToString();
                    XElement campo = docusuario.Descendants("Usuario").FirstOrDefault(u => u.Element("id").Value == zz);
                    if (campo != null)
                    {


                        campo.Element("nombre").Value = txtNombreUs.Text.Trim();
                        campo.Element("primerApellido").Value = txtPrimerApellidoUs.Text.Trim();
                        campo.Element("segundoApellido").Value = txtSegundoApellidoUs.Text.Trim();
                        campo.Element("email").Value = txtEmailUs.Text.Trim();
                        campo.Element("carrera_usuario").Value = ddlCarrerasUs.SelectedValue.ToString();
                        campo.Element("tipo_usuario").Value = ddlTipoUs.SelectedValue.ToString();
                        docusuario.Save(path);
                        Response.Redirect("FrmListaUsuario.aspx");
                    }
                }
                else
                {
                    divMensaje.Visible = true;
                }
            }
            else
            {
                Regex regex = new Regex(@"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$");
                bool c = regex.IsMatch(txtEmailUs.Text.Trim());
                Regex regex1 = new Regex(@"^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{6,}$");
                bool c1 = regex1.IsMatch(txtContrasenaUs.Text.Trim());

                if ((txtNombreUs.Text.Trim() != "" && txtPrimerApellidoUs.Text.Trim() != "" &&
                        txtEmailUs.Text.Trim() != "" && txtContrasenaUs.Text.Trim() != "") && (c) && (c1))
                {

                    //Encriptacion de contraseña con el sha 1
                    var sh = new SHA1CryptoServiceProvider();
                    var cadena = Encoding.ASCII.GetBytes(txtContrasenaUs.Text);
                    var modificado = sh.ComputeHash(cadena);
                    var final = BitConverter.ToString(modificado).Replace("-", "").ToLower();

                    string cad1 = final.ToString();

                    XDocument docusuario;
                    string path = AppDomain.CurrentDomain.BaseDirectory + @"xml\baseUsuarios.xml";
                    docusuario = XDocument.Load(path);

                    var tam = docusuario.Descendants("Usuario").Count();

                    XElement nevouser = new XElement("Usuario",
                                   new XElement("id", tam + 1),
                                   new XElement("nombre", txtNombreUs.Text.Trim()),
                                   new XElement("primerApellido", txtPrimerApellidoUs.Text.Trim()),
                                   new XElement("segundoApellido", txtSegundoApellidoUs.Text.Trim()),
                                   new XElement("email", txtEmailUs.Text.Trim()),
                                   new XElement("contrasena", cad1),
                                   new XElement("carrera_usuario", ddlCarrerasUs.SelectedValue.ToString()),
                                   new XElement("tipo_usuario", ddlTipoUs.SelectedValue.ToString()));
                    docusuario.Root.Add(nevouser);
                    docusuario.Save(path);
                    Response.Redirect("FrmListaUsuario.aspx");

                }
                else
                {
                    divMensaje.Visible = true;
                }
            }


        } 
        



        
        public void CargarCarreras()
        {
            XDocument docusuario;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"xml\carreras.xml";
            docusuario = XDocument.Load(path);
            var contenido = docusuario.Descendants("carrera").Select(car => new
            {

                nombre_carrera = car.Element("nombrec").Value,

            });


            ddlCarrerasUs.DataSource = contenido;
            ddlCarrerasUs.DataValueField = "nombre_carrera";
            ddlCarrerasUs.DataTextField = "nombre_carrera";
            ddlCarrerasUs.DataBind();


        }

        public void CargarDatos(string i)
        {


            XDocument docusuario;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"xml\baseUsuarios.xml";
            docusuario = XDocument.Load(path);
            XElement usuar = docusuario.Descendants("Usuario").FirstOrDefault(p => p.Element("id").Value == i);
            if (usuar != null)
            {
                txtNombreUs.Text = usuar.Element("nombre").Value;
                txtPrimerApellidoUs.Text = usuar.Element("primerApellido").Value;
                txtSegundoApellidoUs.Text = usuar.Element("segundoApellido").Value;
                txtEmailUs.Text = usuar.Element("email").Value;
                txtContrasenaUs.Visible = false;
                txtContrasenaUs.Text = usuar.Element("contrasena").Value;
                txtRepetirContrasenaUs.Visible = false;
                txtRepetirContrasenaUs.Text = usuar.Element("contrasena").Value;
                ddlTipoUs.SelectedValue = usuar.Element("tipo_usuario").Value.ToString();
                ddlCarrerasUs.SelectedValue = usuar.Element("carrera_usuario").Value;
            }


            


        }


    }
}