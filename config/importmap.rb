pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "controllers", to: "controllers/index.js"
pin_all_from "app/javascript/controllers", under: "controllers"