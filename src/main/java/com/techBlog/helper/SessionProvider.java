package com.techBlog.helper;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class SessionProvider {
    private static SessionFactory sessionFactory;

    // Singleton pattern for SessionFactory
    static {
        try {
            Configuration configuration = new Configuration();
            configuration.configure();
            sessionFactory = configuration.buildSessionFactory();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Method to get a new Session for each call
    public static Session getSession() {
    	System.out.println(sessionFactory);
        if (sessionFactory != null) {
            return sessionFactory.openSession();
        }
        throw new RuntimeException("SessionFactory is not configured properly");
    }

    // Method to close the SessionFactory (useful for cleanup, e.g., on app shutdown)
    public static void closeFactory() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}
