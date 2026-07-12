namespace TorneviaWeb.Models
{
    public class Equipo
    {
        public int ID_Equipo { get; set; }
        public string Nombre_Equipo { get; set; } = string.Empty;
        public string? Logo { get; set; }
        public string? Categoria { get; set; }
        public int ID_Usuario { get; set; }

        public Usuario? Usuario { get; set; }
    }
}