<?php

ini_set( 'display_errors', 0 );

// ===================================================
// Load database info and local development parameters
// ===================================================
if ( file_exists( dirname( __FILE__ ) . '/../production-config.php' ) ) {
    define( 'WP_LOCAL_DEV', false );
    include( dirname( __FILE__ ) . '/../production-config.php' );
} else {
    define( 'WP_LOCAL_DEV', true );
    include( dirname( __FILE__ ) . '/../dev-config.php' );
}

// ========================
// Custom Content Directory
// ========================
define( 'WP_CONTENT_DIR', dirname( __FILE__ ) . '/wp-content' );
define( 'WP_CONTENT_URL', 'http://' . $_SERVER['HTTP_HOST'] . '/wp-content' );

// ================================================
// You almost certainly do not want to change these
// ================================================
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

// ================================
// Language
// Leave blank for American English
// ================================
define( 'WPLANG', '' );

// ======================
// Hide errors by default
// ======================
define( 'WP_DEBUG_DISPLAY', false );
define( 'WP_DEBUG', false );

// =========================
// Disable automatic updates
// =========================
define( 'AUTOMATIC_UPDATER_DISABLED', false );

// =======================
// Load WordPress Settings
// =======================
$table_prefix  = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/wp/' );
}
require_once( ABSPATH . 'wp-settings.php' );



















// // ** MySQL settings ** //
// /** The name of the database for WordPress */
// define('DB_NAME', 'wpgit');

// /** MySQL database username */
// define('DB_USER', 'root');

// /** MySQL database password */
// define('DB_PASSWORD', 'root');

// /** MySQL hostname */
// define('DB_HOST', 'localhost');

// /** Database Charset to use in creating database tables. */
// define('DB_CHARSET', 'utf8');

// /** The Database Collate type. Don't change this if in doubt. */
// define('DB_COLLATE', '');

// define('AUTH_KEY',         'h{~oo[3h@)Cxn(r23w^3bdRbkvh?@x`eG~VduWJiU0_dt.0SH5[@+CW3F=N%Ij{q');
// define('SECURE_AUTH_KEY',  '&}q.qxmsd[vQ3fe)|-#Ig`<R%L(Jl%BS|I|~(ktM|JJV|~[%~H?u-]C-t?Kft#Dx');
// define('LOGGED_IN_KEY',    '3eLT$Y0S9aBovU!-e!V ]i+L{}Os-d7HJ2c-:%571fgh-s8>@a!TQ:xo$-{e{6D4');
// define('NONCE_KEY',        'H;a]frV}MX_wjO&1T+o;1hs-x(pW9OW5Xco0L!X$k|tw#|d?iJ1C@D(VIxzkU.;`');
// define('AUTH_SALT',        '[X}CU^hA+-q(|!*[-:6][@aj*KJYgwuH4{L5zu3Jgoh{n5)R/.@{~0z|X::I`dr ');
// define('SECURE_AUTH_SALT', 'HBI&V*%- M2l|8.h|.*qCMz<T@+}8vr1BS,{+*x6dol~BK?K`,stz$ju&-Z=Eod6');
// define('LOGGED_IN_SALT',   'S^Xq-Ge9qm*Z3E5x mGl6i,)n9|<vy7B#JH+V<d^,-tS5MeZeNO/Eq^$u7U5XM+,');
// define('NONCE_SALT',       '$Y&#z-?hJMBMwlW5p0LF=HAGiyK!XFC@+VL37Rj,/O<+<anFH! IKv<Q*KQv=Q+f');

// $table_prefix = 'wp_';

// /* That's all, stop editing! Happy blogging. */

// /** Absolute path to the WordPress directory. */
// if ( !defined('ABSPATH') )
// 	define('ABSPATH', dirname(__FILE__) . '/');

// /** Sets up WordPress vars and included files. */
// require_once(ABSPATH . 'wp-settings.php');
