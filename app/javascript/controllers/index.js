// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import {
  Dropdown, Modal, Tabs, Popover, Toggle, Slideover,
} from 'tailwindcss-stimulus-components';
import Flatpickr from 'stimulus-flatpickr';
import { application } from './application';

// Register each controller with Stimulus
import controllers from './**/*_controller.js';

controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default);
});
application.register('dropdown', Dropdown);
application.register('modal', Modal);
application.register('tabs', Tabs);
application.register('popover', Popover);
application.register('toggle', Toggle);
application.register('slideover', Slideover);
application.register('flatpickr', Flatpickr);
