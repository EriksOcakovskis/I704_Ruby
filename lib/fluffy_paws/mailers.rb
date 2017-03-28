module FluffyPaws
  module Mailers
    class TokenMailer
      include SendGrid

      def send(params)
        from = Email.new(email: 'app65106927@heroku.com')
        subject = "Hi #{params[:user]}, your token for FluffyPaws"
        to = Email.new(email: params[:recipient])
        content = Content.new(type: 'text/html',
                              value: "<html><p>Click the link below to login</p>
                              <a href=\"http://localhost:9292/login/
                              #{params[:token]}\">Click Me!</a>
                              <p>FluffyPaws team</p></html>")
        mail = Mail.new(from, subject, to, content)

        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)
        response.status_code
      end
    end
  end
end
