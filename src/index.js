const core = require('@actions/core');
const { Installer } = require('./installer');

(async () => {
  const installer = new Installer(core.getInput('version'), '../src');
  try {
    await installer.install();
  } catch (e) {
    core.setFailed(e.message);
  }
})();