# frozen_string_literal: true

require "rails_helper"

RSpec.describe Liturgical::Translator do
  describe ".season" do
    it "translates Advento to Advent" do
      expect(described_class.season("Advento")).to eq("Advent")
    end

    it "translates Natal to Christmas" do
      expect(described_class.season("Natal")).to eq("Christmas")
    end

    it "translates Epifania to Epiphany" do
      expect(described_class.season("Epifania")).to eq("Epiphany")
    end

    it "translates Quaresma to Lent" do
      expect(described_class.season("Quaresma")).to eq("Lent")
    end

    it "translates Páscoa to Easter" do
      expect(described_class.season("Páscoa")).to eq("Easter")
    end

    it "translates Tempo Comum to Ordinary Time" do
      expect(described_class.season("Tempo Comum")).to eq("Ordinary Time")
    end

    it "returns the original value for unknown seasons" do
      expect(described_class.season("Unknown")).to eq("Unknown")
    end
  end

  describe ".color" do
    it "translates branco to white" do
      expect(described_class.color("branco")).to eq("white")
    end

    it "translates vermelho to red" do
      expect(described_class.color("vermelho")).to eq("red")
    end

    it "translates roxo to purple" do
      expect(described_class.color("roxo")).to eq("purple")
    end

    it "translates violeta to violet" do
      expect(described_class.color("violeta")).to eq("violet")
    end

    it "translates rosa to rose" do
      expect(described_class.color("rosa")).to eq("rose")
    end

    it "translates verde to green" do
      expect(described_class.color("verde")).to eq("green")
    end

    it "translates preto to black" do
      expect(described_class.color("preto")).to eq("black")
    end

    it "returns the original value for unknown colors" do
      expect(described_class.color("unknown")).to eq("unknown")
    end
  end

  describe ".day_name_en" do
    it "returns Sunday for wday 0" do
      date = Date.new(2025, 11, 30) # A Sunday
      expect(described_class.day_name_en(date)).to eq("Sunday")
    end

    it "returns Monday for wday 1" do
      date = Date.new(2025, 12, 1) # A Monday
      expect(described_class.day_name_en(date)).to eq("Monday")
    end

    it "returns Saturday for wday 6" do
      date = Date.new(2025, 12, 6) # A Saturday
      expect(described_class.day_name_en(date)).to eq("Saturday")
    end
  end

  describe ".day_name_pt" do
    it "returns Domingo for wday 0" do
      date = Date.new(2025, 11, 30) # A Sunday
      expect(described_class.day_name_pt(date)).to eq("Domingo")
    end

    it "returns Segunda-feira for wday 1" do
      date = Date.new(2025, 12, 1) # A Monday
      expect(described_class.day_name_pt(date)).to eq("Segunda-feira")
    end

    it "returns Sábado for wday 6" do
      date = Date.new(2025, 12, 6) # A Saturday
      expect(described_class.day_name_pt(date)).to eq("Sábado")
    end
  end

  describe "aliases" do
    it "responds to translate_season" do
      expect(described_class.translate_season("Advento")).to eq("Advent")
    end

    it "responds to translate_color" do
      expect(described_class.translate_color("branco")).to eq("white")
    end

    it "responds to day_name_br" do
      date = Date.new(2025, 11, 30)
      expect(described_class.day_name_br(date)).to eq("Domingo")
    end
  end
end
