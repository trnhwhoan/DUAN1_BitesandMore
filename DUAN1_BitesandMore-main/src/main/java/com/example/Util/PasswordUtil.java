package com.example.Util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordUtil {
    private static final int ITERATIONS = 65_536;
    private static final int KEY_LENGTH = 256;
    private static final SecureRandom RANDOM = new SecureRandom();

    private PasswordUtil() { }

    public static String hash(String password) {
        try {
            byte[] salt = new byte[16];
            RANDOM.nextBytes(salt);
            byte[] hash = derive(password.toCharArray(), salt);
            Base64.Encoder encoder = Base64.getEncoder();
            return "pbkdf2$" + encoder.encodeToString(salt) + "$" + encoder.encodeToString(hash);
        } catch (Exception e) {
            throw new IllegalStateException("Unable to hash password", e);
        }
    }

    public static boolean matches(String password, String storedValue) {
        if (password == null || storedValue == null) return false;
        try {
            if (!storedValue.startsWith("pbkdf2$")) {
                // Compatibility for users created before password hashing was introduced.
                return MessageDigest.isEqual(password.getBytes(StandardCharsets.UTF_8),
                        storedValue.getBytes(StandardCharsets.UTF_8));
            }
            String[] parts = storedValue.split("\\$", -1);
            if (parts.length != 3) return false;
            Base64.Decoder decoder = Base64.getDecoder();
            byte[] expected = decoder.decode(parts[2]);
            byte[] actual = derive(password.toCharArray(), decoder.decode(parts[1]));
            return MessageDigest.isEqual(expected, actual);
        } catch (Exception e) {
            return false;
        }
    }

    private static byte[] derive(char[] password, byte[] salt) throws Exception {
        PBEKeySpec spec = new PBEKeySpec(password, salt, ITERATIONS, KEY_LENGTH);
        try {
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(spec).getEncoded();
        } finally {
            spec.clearPassword();
        }
    }
}
