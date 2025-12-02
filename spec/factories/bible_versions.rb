# frozen_string_literal: true

FactoryBot.define do
  factory :bible_version do
    sequence(:code) { |n| "bible_#{n}" }
    sequence(:name) { |n| "Bible Version #{n}" }
    full_name { "Full Bible Version Name" }
    language { "pt-BR" }
    description { "A Bible translation" }
    publisher { "Test Publisher" }
    year { 2020 }
    is_recommended { false }
    license { "open" }
    is_active { true }

    trait :recommended do
      is_recommended { true }
    end

    trait :nvi do
      code { "nvi" }
      name { "NVI" }
      full_name { "Nova Versão Internacional" }
      publisher { "Vida" }
      year { 2011 }
      is_recommended { true }
    end

    trait :ara do
      code { "ara" }
      name { "ARA" }
      full_name { "Almeida Revista e Atualizada" }
      publisher { "SBB" }
      year { 1993 }
    end

    trait :inactive do
      is_active { false }
    end
  end
end
