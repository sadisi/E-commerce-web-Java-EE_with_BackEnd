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

            // HTML content for styling the message
            String emailContent = "<html>"
                    + "<body>"
                    + "<p style='font-size: 16px; color: #333;'>Thank you for your purchase!</p>"
                    + "<p style='font-size: 14px; color: #555;'>Your order ID is: <strong>" + orderNum + "</strong></p>"
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
