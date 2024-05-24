package edu.thi.java;
import java.util.Random;

public class IBANGenerator {
    public static String generateIBAN() {
        // Ländercode (hier einfach DE für Deutschland)
        String countryCode = "DE";
        // Prüfziffer
        String checksum = generateRandomNumericString(2);
        // Bankleitzahl (Bank Identifier Code)
        String bankCode = generateRandomNumericString(8);
        // Kontonummer
        String accountNumber = generateRandomNumericString(10);
        // IBAN zusammenstellen
        String iban = countryCode + checksum + bankCode + accountNumber;
        return iban;
    }
    // Hilfsmethode zur Generierung einer zufälligen numerischen Zeichenkette mit einer bestimmten Länge
    private static String generateRandomNumericString(int length) {
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }
    public static void main(String[] args) {
        String randomIBAN = generateIBAN();
        System.out.println("Random IBAN: " + randomIBAN);
    }
}
