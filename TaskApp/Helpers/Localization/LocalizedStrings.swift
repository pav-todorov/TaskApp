//
//  LocalizedStrings.swift
//  TaskApp
//
//  Created by Pavel on 27.02.23.
//

import Foundation

// MARK: - Localized Strings
public struct LocalizedStrings {
    // MARK: Initializers
    private init() {}
    
    // MARK: - Common
    public struct Common {
        // MARK: Properties
        public static var common_ok: String { "common_ok".localized() }
        
        // MARK: Initializers
        private init() {}
    }
    
    // MARK: - Alerts
    public struct Alerts {
        // MARK: Properties
        
        // MARK: Titles
        public static var alerts_titles_internal_login_success: String { "alerts_titles_internal_login_success".localized() }
        public static var alerts_titles_login_as_guest: String { "alerts_titles_login_as_guest".localized() }
        public static var alerts_titles_loading: String { "alerts_titles_loading".localized() }
        public static var alerts_titles_wrong_credentials: String { "alerts_titles_wrong_credentials".localized() }
        public static var alerts_titles_server_error: String { "alerts_titles_server_error".localized() }
        public static var alerts_titles_system_error: String { "alerts_titles_system_error".localized() }
        public static var alerts_titles_: String { "".localized() }
        public static var alerts_titles_apple_login_welcome: String { "alerts_titles_apple_login_welcome".localized() }
        public static var alerts_titles_apple_login_missing_email: String { "alerts_titles_apple_login_missing_email".localized() }
        public static var alerts_titles_facebook_login_welcome: String { "alerts_titles_facebook_login_welcome".localized() }
        public static var alerts_titles_facebook_login_failed: String { "alerts_titles_facebook_login_failed".localized() }
        public static var alerts_titles_google_login_welcome: String { "alerts_titles_google_login_welcome".localized() }
        public static var alerts_titles_google_login_failed: String { "alerts_titles_google_login_failed".localized() }
        
        
        // MARK: Messages
        public static var alerts_messages_internal_login_success: String { "alerts_messages_internal_login_success".localized() }
        public static var alerts_messages_login_as_guest: String { "alerts_messages_login_as_guest".localized() }
        public static var alerts_messages_loading: String { "alerts_messages_loading".localized() }
        public static var alerts_messages_wrong_credentials: String { "alerts_messages_wrong_credentials".localized() }
        public static var alerts_messages_server_error: String { "alerts_messages_server_error".localized() }
        public static var alerts_messages_system_error: String { "alerts_messages_system_error".localized() }
        public static var alerts_messages_apple_login_welcome: String { "alerts_messages_apple_login_welcome".localized() }
        public static var alerts_messages_apple_login_missing_email: String { "alerts_messages_apple_login_missing_email".localized() }
        public static var alerts_messages_facebook_login_welcome: String { "alerts_messages_facebook_login_welcome".localized() }
        public static var alerts_messages_facebook_login_failed: String { "alerts_messages_facebook_login_failed".localized() }
        public static var alerts_messages_google_login_welcome: String { "alerts_messages_google_login_welcome".localized() }
        public static var alerts_messages_google_login_failed: String { "alerts_messages_google_login_failed".localized() }
        
        // MARK: Initializers
        private init() {}
    }
    
    // MARK: - Scenes
    public struct Scenes {
        // MARK: Initializers
        private init() {}
        
        // MARK: Start Screen
        public struct StartScreen {
            // MARK: Properties
            public static var start_screen_menu_item_login: String { "start_screen_menu_item_login".localized() }
            public static var start_screen_menu_item_signup: String { "start_screen_menu_item_signup".localized() }
            
            // MARK: Initializers
            private init() {}
        }
    }
    
    // MARK: - Views
    public struct Views {
        // MARK: Login Cell
        public struct LoginCell {
            // MARK: Properties
            public static var login_cell_title: String { "login_cell_title".localized() }
            public static var login_cell_subtitle: String { "login_cell_subtitle".localized() }
            public static var login_cell_external_login_section_title: String { "login_cell_external_login_section_title".localized() }
            
            public static var login_cell_buttons_login: String { "login_cell_buttons_login".localized() }
            public static var login_cell_buttons_apple: String { "login_cell_buttons_apple".localized() }
            public static var login_cell_buttons_facebook: String { "login_cell_buttons_facebook".localized() }
            public static var login_cell_buttons_google: String { "login_cell_buttons_google".localized() }
            public static var login_cell_buttons_guest: String { "login_cell_buttons_guest".localized() }
            public static var login_cell_buttons_reset: String { "login_cell_buttons_reset".localized() }
            
            // MARK: Initializers
            private init() {}
        }
        
        // MARK: Signup Cell
        public struct SignupCell {
            // MARK: Properties
            public static var signup_cell_title: String { "signup_cell_title".localized() }
            
            // MARK: Initializers
            private init() {}
        }
        
        // MARK: User Credentials Cells
        public struct CredentialsCells {
            // MARK: User Cell
            public struct UserCell {
                public static var user_cell_title: String { "user_cell_title".localized() }
                public static var user_cell_placeholder: String { "user_cell_placeholder".localized() }
                public static var user_cell_assistive_text: String { "user_cell_assistive_text".localized() }
                
                // MARK: Initializers
                private init() {}
            }
            
            // MARK: Password Cell
            public struct PasswordCell {
                public static var password_cell_title: String { "password_cell_title".localized() }
                public static var password_cell_placeholder: String { "password_cell_placeholder".localized() }
                public static var password_cell_assistive_text: String { "password_cell_assistive_text".localized() }
                
                // MARK: Initializers
                private init() {}
            }
            
            // MARK: Initializers
            private init() {}
        }
        
        // MARK: Initializers
        private init() {}
    }
}
