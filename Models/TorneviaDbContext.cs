using Microsoft.EntityFrameworkCore;

namespace TorneviaWeb.Models
{
    public class TorneviaDbContext : DbContext
    {
        public TorneviaDbContext(DbContextOptions<TorneviaDbContext> options) : base(options)
        {
        }

        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Torneo> Torneos { get; set; }
        public DbSet<Equipo> Equipos { get; set; }
        public DbSet<TorneoEquipo> Torneo_Equipo { get; set; }
        public DbSet<Jugador> Jugadores { get; set; }
        public DbSet<Partido> Partidos { get; set; }
        public DbSet<Estadistica> Estadisticas { get; set; }
        public DbSet<Noticia> Noticias { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Usuarios
            modelBuilder.Entity<Usuario>().ToTable("Usuarios");
            modelBuilder.Entity<Usuario>().HasKey(u => u.ID_Usuario);

            // Torneos
            modelBuilder.Entity<Torneo>().ToTable("Torneos");
            modelBuilder.Entity<Torneo>().HasKey(t => t.ID_Torneo);
            modelBuilder.Entity<Torneo>()
                .HasOne(t => t.Administrador)
                .WithMany()
                .HasForeignKey(t => t.ID_Administrador);

            // Equipos
            modelBuilder.Entity<Equipo>().ToTable("Equipos");
            modelBuilder.Entity<Equipo>().HasKey(e => e.ID_Equipo);
            modelBuilder.Entity<Equipo>()
                .HasOne(e => e.Usuario)
                .WithMany()
                .HasForeignKey(e => e.ID_Usuario);

            // Torneo_Equipo (clave compuesta)
            modelBuilder.Entity<TorneoEquipo>().ToTable("Torneo_Equipo");
            modelBuilder.Entity<TorneoEquipo>().HasKey(te => new { te.ID_Torneo, te.ID_Equipo });
            modelBuilder.Entity<TorneoEquipo>()
                .HasOne(te => te.Torneo)
                .WithMany()
                .HasForeignKey(te => te.ID_Torneo);
            modelBuilder.Entity<TorneoEquipo>()
                .HasOne(te => te.Equipo)
                .WithMany()
                .HasForeignKey(te => te.ID_Equipo);

            // Jugadores
            modelBuilder.Entity<Jugador>().ToTable("Jugadores");
            modelBuilder.Entity<Jugador>().HasKey(j => j.ID_Jugador);
            modelBuilder.Entity<Jugador>()
                .HasOne(j => j.Equipo)
                .WithMany()
                .HasForeignKey(j => j.ID_Equipo);
            modelBuilder.Entity<Jugador>()
                .HasOne(j => j.Usuario)
                .WithMany()
                .HasForeignKey(j => j.ID_Usuario)
                .IsRequired(false);

            // Partidos
            modelBuilder.Entity<Partido>().ToTable("Partidos");
            modelBuilder.Entity<Partido>().HasKey(p => p.ID_Partido);
            modelBuilder.Entity<Partido>()
                .HasOne(p => p.Torneo)
                .WithMany()
                .HasForeignKey(p => p.ID_Torneo);

            // Evita que EF intente aplicar cascada doble en Equipo_Local / Equipo_Visitante
            modelBuilder.Entity<Partido>()
                .HasOne<Equipo>()
                .WithMany()
                .HasForeignKey(p => p.Equipo_Local)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Partido>()
                .HasOne<Equipo>()
                .WithMany()
                .HasForeignKey(p => p.Equipo_Visitante)
                .OnDelete(DeleteBehavior.Restrict);

            // Estadisticas
            modelBuilder.Entity<Estadistica>().ToTable("Estadisticas");
            modelBuilder.Entity<Estadistica>().HasKey(e => e.ID_Estadistica);
            modelBuilder.Entity<Estadistica>()
                .HasOne(e => e.Partido)
                .WithMany()
                .HasForeignKey(e => e.ID_Partido);
            modelBuilder.Entity<Estadistica>()
                .HasOne(e => e.Jugador)
                .WithMany()
                .HasForeignKey(e => e.ID_Jugador);

            // Noticias
            modelBuilder.Entity<Noticia>().ToTable("Noticias");
            modelBuilder.Entity<Noticia>().HasKey(n => n.ID_Noticia);
            modelBuilder.Entity<Noticia>()
                .HasOne(n => n.Usuario)
                .WithMany()
                .HasForeignKey(n => n.ID_Usuario);
            modelBuilder.Entity<Noticia>()
                .HasOne(n => n.Torneo)
                .WithMany()
                .HasForeignKey(n => n.ID_Torneo)
                .IsRequired(false);
        }
    }
}