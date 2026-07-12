namespace TorneviaWeb.Models
{
    public class Noticia
    {
        public int ID_Noticia { get; set; }
        public string Titulo { get; set; } = string.Empty;
        public string? Contenido { get; set; }
        public DateTime Fecha_Publicacion { get; set; }
        public int ID_Usuario { get; set; }
        public int? ID_Torneo { get; set; }

        public Usuario? Usuario { get; set; }
        public Torneo? Torneo { get; set; }
    }
}