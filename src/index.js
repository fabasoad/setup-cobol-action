const core = require('@actions/core');
const { Installer } = require('./installer');

(async () => {
  const installer = new Installer(core.getInput('version'));
  await installer.install();
})();