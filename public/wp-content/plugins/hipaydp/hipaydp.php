<?php

/**
 * The plugin bootstrap file
 *
 * This file is read by WordPress to generate the plugin information in the plugin
 * admin area. This file also includes all of the dependencies used by the plugin,
 * registers the activation and deactivation functions, and defines a function
 * that starts the plugin.
 *
 * @link              #
 * @since             1.0.0
 * @package           Hipay_Dev_Portal
 *
 * @wordpress-plugin
 * Plugin Name:       HiPay Developer Portal
 * Plugin URI:        #
 * Description:       Plugin with awesome features for HiPay's developer portal
 * Version:           1.0.0
 * Author:            Ben Notteghem
 * Author URI:        #
 * License:           GPL-2.0+
 * License URI:       http://www.gnu.org/licenses/gpl-2.0.txt
 * Text Domain:       hipaydp
 * Domain Path:       /languages
 */

// If this file is called directly, abort.
if ( ! defined( 'WPINC' ) ) {
	die;
}

/**
 * The code that runs during plugin activation.
 * This action is documented in includes/class-hipaydp-activator.php
 */
function activate_Hipay_Dev_Portal() {
	require_once plugin_dir_path( __FILE__ ) . 'includes/class-hipaydp-activator.php';
	Hipay_Dev_Portal_Activator::activate();
}

/**
 * The code that runs during plugin deactivation.
 * This action is documented in includes/class-hipaydp-deactivator.php
 */
function deactivate_Hipay_Dev_Portal() {
	require_once plugin_dir_path( __FILE__ ) . 'includes/class-hipaydp-deactivator.php';
	Hipay_Dev_Portal_Deactivator::deactivate();
}

register_activation_hook( __FILE__, 'activate_Hipay_Dev_Portal' );
register_deactivation_hook( __FILE__, 'deactivate_Hipay_Dev_Portal' );

/**
 * The core plugin class that is used to define internationalization,
 * admin-specific hooks, and public-facing site hooks.
 */
require plugin_dir_path( __FILE__ ) . 'includes/class-hipaydp.php';

/**
 * Begins execution of the plugin.
 *
 * Since everything within the plugin is registered via hooks,
 * then kicking off the plugin from this point in the file does
 * not affect the page life cycle.
 *
 * @since    1.0.0
 */
function run_Hipay_Dev_Portal() {

	$plugin = new Hipay_Dev_Portal();
	$plugin->run();

}
run_Hipay_Dev_Portal();