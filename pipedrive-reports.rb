#!/usr/bin/env ruby

######  Configuracion  #########
PIPEDRIVE_API_KEY = ENV['PIPEDRIVE_API_KEY']
PIPEDRIVE_DAYS_AGO = ENV['PIPEDRIVE_DAYS_AGO'].to_i

EMAIL_FROM = ENV['PIPEDRIVE_EMAIL_FROM']
EMAIL_TO = ENV['PIPEDRIVE_EMAIL_TO']
EMAIL_SMTP = ENV['PIPEDRIVE_EMAIL_SMTP']
###### No editar bajo esta línea ########

require 'date'
require 'mail'
require 'erb'
require 'pipedrive-ruby'

class Deal
  
  attr_accessor :all
  
  def initialize()
    Pipedrive.authenticate(PIPEDRIVE_API_KEY)
    @all = Pipedrive::Deal.all
  end
  
  # Sin actualizacion por 10 días
  def without_updates
    deals = @all.keep_if {|d| d.status == "open" }
    deals.select {|deal| (Date.today - Date.parse(deal.update_time)) >= PIPEDRIVE_DAYS_AGO }
  end
  
end

class Report
  attr_accessor :deals, :days_ago
  
  def initialize(deals)
    @deals = deals
    @days_ago = PIPEDRIVE_DAYS_AGO
  end
  
  def send
    b = binding
    
    Mail.defaults do
      delivery_method :smtp, address: EMAIL_SMTP, port: 25
    end
    
    Mail.deliver do 
        to EMAIL_TO
        from EMAIL_FROM
        subject "Repor de oportunidades abandonadas"
        html_part do
          content_type 'text/html; charset=UTF-8'
          body ERB.new(File.read('reporte.erb')).result(b)
        end
      end
  end
  
end

# Now do stuff with it
deal = Deal.new

reporte = Report.new deal.without_updates

reporte.send