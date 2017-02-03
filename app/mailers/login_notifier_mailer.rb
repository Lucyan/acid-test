class LoginNotifierMailer < ApplicationMailer
    default :from => 'no-response@acid-test.com'

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_notifier_email(email, mensaje, user_agent)
        @mensaje = mensaje
        @user_agent = user_agent
        mail(   :to => email,
                :subject => 'Se intentó una nueva auntenticación' )
    end
end
