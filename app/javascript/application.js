/* eslint no-console:0 */

// Rails functionality
import Rails from '@rails/ujs';
import { Turbo } from '@hotwired/turbo-rails';
import '@rails/actiontext';

// ActionCable Channels
import './channels';

// Stimulus controllers
import './controllers';

// Jumpstart Pro & other Functionality
import './src/**/*';

// Make accessible for Electron and Mobile adapters
window.Rails = Rails;
window.Turbo = Turbo;

require('@rails/activestorage').start();
require('local-time').start();

// Start Rails UJS
Rails.start();
