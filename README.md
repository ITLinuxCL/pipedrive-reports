### Qué es esto?
Un simple script para enviar reportes por correo de oportunidades de negocio que no han sido actualizadas durante los últimos ```PIPEDRIVE_DAYS_AGO``` días.


### Cómo se instala?
Por ahora debes tener instalado Ruby >= 2.0 y hacer:

```bash
$ git clone git remote add origin git@github.com:ITLinuxCL/pipedrive-reports.git
$ cd pipedrive-reports
$ bundle install
```

### Cómo se ejecuta?
Parado en el mismo directorio, para que tome el template, ejecutas:

```bash
$ PIPEDRIVE_EMAIL_FROM='pipdrive@example.com' PIPEDRIVE_EMAIL_TO='sales@example.com' \
PIPEDRIVE_EMAIL_SMTP='mail.example.com' PIPEDRIVE_API_KEY='DKDJDJDJD323232'\
PIPEDRIVE_DAYS_AGO=14 ruby pipedrive-reports.rb
```

Son un montón de variables de entorno, pero bueno ;)