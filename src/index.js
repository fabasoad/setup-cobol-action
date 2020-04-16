const core = require('@actions/core');
const path = require('path');
const { Installer } = require('./installer');

(async () => {
  const installer = new Installer(core.getInput('version'), path.join(__dirname, '../src'));
  try {
    await installer.install();
  } catch (e) {
    core.setFailed(e.message);
  }
})();