namespace TorneviaWeb.Models
{
    public class SesionUsuario
    {
        public int? ID_Usuario { get; set; }
        public string? Nombre { get; set; }
        public string? Rol { get; set; }

        public bool EstaAutenticado => ID_Usuario != null;
        public bool EsAdministrador => EstaAutenticado && Rol == "Administrador";

        public void IniciarSesion(Usuario usuario)
        {
            ID_Usuario = usuario.ID_Usuario;
            Nombre = usuario.Nombre;
            Rol = usuario.Rol;
        }

        public void CerrarSesion()
        {
            ID_Usuario = null;
            Nombre = null;
            Rol = null;
        }
    }
}