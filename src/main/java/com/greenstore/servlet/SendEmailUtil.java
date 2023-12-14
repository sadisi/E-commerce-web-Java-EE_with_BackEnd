package com.greenstore.servlet;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendEmailUtil {
    public static void sendOrderConfirmationEmail(String userEmail, String orderNum) {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("bhathikanilesh000@gmail.com", "vngj tdfz pvhe dzym");
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("bhathikanilesh000@gmail.com"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
            message.setSubject("Order Confirmation");

            //email massage
            String emailContent = "<html>"
                    + "<head>"
                    + "<style>"
                    + "body {"
                    + "    font-family: 'Arial', sans-serif;"
                    + "    background-color: #f4f4f4;"
                    + "    color: #333;"
                    + "}"
                    + ".header {"
                    + "    background-color: #800080; /* Purple color */"
                    + "    color: #000; /* Black color */"
                    + "    padding: 10px;"
                    + "    text-align: center;"
                    + "}"
                    + "p {"
                    + "    font-size: 16px;"
                    + "    margin-bottom: 10px;"
                    + "}"
                    + "strong {"
                    + "    color: #555;"
                    + "}"
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<div class='header'>"
                    + "    <h1>Swift<span style='color: #800080;'>Super</span></h1>"
                    + "</div>"
                    + "<p>Thank you for your purchase!</p>"
                    + "<p>Your order ID is: <strong>" + orderNum + "</strong></p>"
                    + "</body>"
                    + "</html>";



            // Set the HTML content
            message.setContent(emailContent, "text/html");

            Transport.send(message);

            System.out.println("Order confirmation email sent successfully.");

        } catch (MessagingException mex) {
            mex.printStackTrace();
            System.out.println("Error sending order confirmation email.");
        }
    }
}
