const exec = require('@actions/exec');
const fs = require('fs');
const os = require('os');
const path = require('path');

const { assert } = require('chai');
const itParam = require('mocha-param');
const sinon = require('sinon');

const {
  Installer,
  UnsupportedOSError,
  UnsupportedVersionError
} = require('../src/installer');

const fixture = ['Darwin', 'Windows_NT'];

const validVersions = ['3.1.2', '3.0-rc1', '3.1-rc1', '3.1.1'];
const invalidVersion = 'y50pgz2b';

describe('Test Installer class', () => {
  let fsChmodSyncStub;
  let execExecStub;
  let osTypeStub;

  beforeEach(() => {
    fsChmodSyncStub = sinon.stub(fs, 'chmodSync');
    execExecStub = sinon.stub(exec, 'exec');
    osTypeStub = sinon.stub(os, 'type');
  });

  itParam('should build correct exec file name for Linux OS (${value})',
    validVersions, (validVersion) => {
      osTypeStub.returns('Linux');

      const installer = new Installer(validVersion);

      const expected = 'install-cobol-linux.sh';
      const actual = installer._execFileName();
      assert.equal(expected, actual);
    });

  itParam('should not build exec file name for ${value} OS', fixture,
    (osType) => {
      osTypeStub.returns(osType);

      const installer = new Installer(validVersions[0]);

      try {
        installer._execFileName();
      } catch (e) {
        if (e instanceof UnsupportedOSError) {
          return;
        }
      }
      // eslint-disable-next-line new-cap
      assert.Throw();
    });

  itParam('should install correctly for Linux OS (${value})',
    validVersions, async (version) => {
      const execFileName = 'install-cobol-linux.sh';

      osTypeStub.returns('Linux');

      const installer = new Installer(version);
      await installer.install();

      execExecStub.calledOnceWith(
        path.join(__dirname, execFileName),
        [version]
      );
      fsChmodSyncStub.calledOnceWith(path.join(__dirname, execFileName), '777');
    });

  itParam('should not install for ${value} OS', fixture, async (osType) => {
    osTypeStub.returns(osType);

    const installer = new Installer(validVersions[0]);
    try {
      await installer.install();
    } catch (e) {
      if (e instanceof UnsupportedOSError) {
        assert.isTrue(execExecStub.notCalled);
        assert.isTrue(fsChmodSyncStub.notCalled);
        return;
      }
    }
    // eslint-disable-next-line new-cap
    assert.Throw();
  });

  it('should not install invalid version', async () => {
    osTypeStub.returns('Linux');

    const installer = new Installer(invalidVersion);
    try {
      await installer.install();
    } catch (e) {
      if (e instanceof UnsupportedVersionError) {
        assert.isTrue(execExecStub.notCalled);
        assert.isTrue(fsChmodSyncStub.notCalled);
        return;
      }
    }
    // eslint-disable-next-line new-cap
    assert.Throw();
  });

  afterEach(() => {
    sinon.restore();
  });
});
