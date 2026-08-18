using CasoEstudio2.Models;
using Microsoft.EntityFrameworkCore;

namespace CasoEstudio2.Data
{
    public class CasoEstudioContext : DbContext
    {
        public CasoEstudioContext(DbContextOptions<CasoEstudioContext> options)
            : base(options)
        {
        }

        public DbSet<CasasModel> CasasSistema { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<CasasModel>()
                .ToTable("CasasSistema", "dbo")
                .HasKey(c => c.IdCasa);

            modelBuilder.Entity<CasasModel>()
                .Property(c => c.IdCasa)
                .HasColumnName("IdCasa");

            modelBuilder.Entity<CasasModel>()
                .Property(c => c.DescripcionCasa)
                .HasColumnName("DescripcionCasa")
                .HasMaxLength(500);

            modelBuilder.Entity<CasasModel>()
                .Property(c => c.PrecioCasa)
                .HasColumnName("PrecioCasa")
                .HasPrecision(10, 2);

            modelBuilder.Entity<CasasModel>()
                .Property(c => c.UsuarioAlquiler)
                .HasColumnName("UsuarioAlquiler")
                .HasMaxLength(30)
                .IsRequired(false);

            modelBuilder.Entity<CasasModel>()
                .Property(c => c.FechaAlquiler)
                .HasColumnName("FechaAlquiler");
        }
    }
}
