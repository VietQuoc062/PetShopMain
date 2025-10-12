package com.petshop.util;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class DatabaseUtil {

	// JDBC URL: use SQL auth (remove integratedSecurity)
	private static final String JDBC_URL =
		"jdbc:sqlserver://DESKTOP-0AN9F32:1433;" +
		"databaseName=PETSHOP;" +
		"encrypt=true;" +
		"trustServerCertificate=true;";

	// SQL Server credentials
	private static final String DB_USER = "PETSHOP";
	private static final String DB_PASSWORD = "petshop";

	private static EntityManagerFactory emf;

	static {
		try {
			// Try to load mssql-jdbc_auth DLL for Windows Integrated Authentication
			loadSqlServerAuthDll();

			emf = Persistence.createEntityManagerFactory("petshopPU");
			// Đóng EntityManagerFactory khi JVM shutdown để tránh leak
			Runtime.getRuntime().addShutdownHook(new Thread(() -> {
				closeFactory();
			}));
		} catch (Throwable ex) {
			// Log lỗi nhưng không ném ExceptionInInitializerError để tránh NoClassDefFoundError
			System.err.println("Initial EntityManagerFactory creation failed (will retry lazily): " + ex.getMessage());
			ex.printStackTrace();
			emf = null; // sẽ thử khởi tạo lại khi cần
		}
	}

	/**
	 * Thử load DLL xác thực của Microsoft JDBC driver để hỗ trợ integratedSecurity=true.
	 * Bạn có thể đặt biến môi trường MSSQL_JDBC_AUTH_DLL=/full/path/to/mssql-jdbc_auth-<version>.dll
	 * Hoặc đặt DLL vào %JAVA_HOME%\\bin hoặc %CATALINA_HOME%\\bin
	 */
	private static void loadSqlServerAuthDll() {
		// Env var can point to exact DLL file
		String envPath = System.getenv("MSSQL_JDBC_AUTH_DLL");
		if (envPath != null && !envPath.isBlank()) {
			File f = new File(envPath);
			if (f.exists()) {
				try {
					System.load(f.getAbsolutePath());
					System.out.println("Loaded mssql-jdbc_auth DLL from MSSQL_JDBC_AUTH_DLL: " + f.getAbsolutePath());
					return;
				} catch (UnsatisfiedLinkError ule) {
					System.err.println("Failed to load DLL from MSSQL_JDBC_AUTH_DLL: " + ule.getMessage());
				}
			} else {
				System.err.println("MSSQL_JDBC_AUTH_DLL is set but file not found: " + envPath);
			}
		}

		// Try common locations: java.home/bin and catalina.base/bin
		String javaHome = System.getProperty("java.home");
		String catalinaBase = System.getProperty("catalina.base");
		String dllName = "mssql-jdbc_auth-13.2.0.x64.dll"; // adjust if using different version/arch

		String[] tryPaths = new String[] {
			javaHome != null ? javaHome + File.separator + "bin" + File.separator + dllName : null,
			catalinaBase != null ? catalinaBase + File.separator + "bin" + File.separator + dllName : null,
			System.getProperty("user.dir") + File.separator + dllName
		};

		for (String p : tryPaths) {
			if (p == null) continue;
			File f = new File(p);
			if (f.exists()) {
				try {
					System.load(f.getAbsolutePath());
					System.out.println("Loaded mssql-jdbc_auth DLL from: " + f.getAbsolutePath());
					return;
				} catch (UnsatisfiedLinkError ule) {
					System.err.println("Failed to load DLL from " + f.getAbsolutePath() + ": " + ule.getMessage());
				}
			}
		}

		// If reached here, DLL not loaded; print clear guidance
		System.err.println("mssql-jdbc_auth DLL not loaded. To use Windows Integrated Authentication (integratedSecurity=true):");
		System.err.println(" - Place the matching mssql-jdbc_auth-<version>.dll (x64 or x86) into your JVM bin folder (e.g. %JAVA_HOME%\\bin) OR Tomcat bin folder (%CATALINA_HOME%\\bin)");
		System.err.println(" - Or set environment MSSQL_JDBC_AUTH_DLL to the full path of the DLL before starting Tomcat");
		System.err.println(" - Ensure DLL arch (x64/x86) matches your JVM. See Microsoft JDBC driver documentation.");
	}

	/**
	 * Lấy EntityManager từ EntityManagerFactory (lazy-init nếu EMF chưa có)
	 */
	public static EntityManager getEntityManager() {
		// Nếu EMF chưa có hoặc đã đóng, thử khởi tạo lại
		if (emf == null || !emf.isOpen()) {
			try {
				// try loading DLL again (in case env set after class load)
				loadSqlServerAuthDll();
				emf = Persistence.createEntityManagerFactory("petshopPU");
			} catch (Throwable ex) {
				throw new IllegalStateException(
					"Could not create EntityManagerFactory. Check persistence.xml, classpath and Windows authentication DLL. "
					+ "If using integratedSecurity=true, ensure mssql-jdbc_auth-<version>.dll is on the JVM library path or set MSSQL_JDBC_AUTH_DLL env var. Cause: "
					+ ex.getMessage(), ex);
			}
		}
		return emf.createEntityManager();
	}

	/**
	 * Đóng EntityManager an toàn
	 */
	public static void closeEntityManager(EntityManager em) {
		if (em != null && em.isOpen()) {
			try {
				em.close();
			} catch (Exception e) {
				System.err.println("Error closing EntityManager: " + e.getMessage());
			}
		}
	}

	/**
	 * Đóng EntityManagerFactory khi ứng dụng tắt
	 */
	public static void closeFactory() {
		if (emf != null && emf.isOpen()) {
			try {
				emf.close();
			} catch (Exception e) {
				System.err.println("Error closing EntityManagerFactory: " + e.getMessage());
			}
		}
	}

	/**
	 * BACKWARD COMPATIBILITY: cung cấp Connection JDBC cho các DAO hiện có
	 */
	public static Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			// use SQL authentication
			connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
		} catch (ClassNotFoundException e) {
			System.err.println("JDBC Driver not found: " + e.getMessage());
		} catch (SQLException e) {
			System.err.println("Database connection failed: " + e.getMessage());
			e.printStackTrace();
		}
		return connection;
	}

	public static void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				System.err.println("Error closing database connection: " + e.getMessage());
			}
		}
	}
}