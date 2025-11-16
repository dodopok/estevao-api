class LiturgicalColor < ApplicationRecord
  # Validações
  validates :name, presence: true, uniqueness: true
  validates :hex_code, format: { with: /\A#[0-9A-Fa-f]{6}\z/, message: "deve ser um código hexadecimal válido" }

  # Constantes para as cores conforme as normas
  COLORS = {
    branco: { hex: "#FFFFFF", description: "Natal, Páscoa, Festas do Senhor, Santos não-mártires" },
    vermelho: { hex: "#DC143C", description: "Semana Santa, Pentecostes, Mártires, Espírito Santo" },
    roxo: { hex: "#800080", description: "Quaresma" },
    violeta: { hex: "#8B00FF", description: "Advento" },
    azul_escuro: { hex: "#00008B", description: "Advento (alternativo)" },
    rosa: { hex: "#FFB6C1", description: "3º Domingo Advento, 4º Domingo Quaresma" },
    verde: { hex: "#228B22", description: "Tempo Comum" },
    preto: { hex: "#000000", description: "Sexta-Feira da Paixão (opcional)" },
    pano_cru: { hex: "#F5DEB3", description: "Quaresma (alternativo ao roxo)" }
  }.freeze
end
