package com.farm.etc;

import java.security.SecureRandom;

public class RandomPasswordGenerator {
	private static final String CHARACTERS = "ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz0123456789";
    private static final SecureRandom random = new SecureRandom();

    public static String generatePass(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }
}
