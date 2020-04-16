const exec = require('@actions/exec');
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

const fixture = ['Darwin','Windows_NT'];

const validVersion = '3.0-rc1';
const invalidVersion = 'y50pgz2b';

describe('Test Installer class', () => {

  let execExecStub;
  let osTypeStub;

  beforeEach(() => {
    execExecStub = sinon.stub(exec, 'exec');
    osTypeStub = sinon.stub(os, 'type');
  });

  it('should build correct exec file name for Linux OS', () => {
    osTypeStub.returns('Linux');

    const installer = new Installer(validVersion);

    const actual = installer._execFileName();
    assert.equal('install-cobol-linux.sh', actual);
  });

  itParam('should not build exec file name for ${value} OS', fixture, (osType) => {
    osTypeStub.returns(osType);

    const installer = new Installer(validVersion);

    try {
      installer._execFileName();
    } catch (e) {
      if (e instanceof UnsupportedOSError) {
        return;
      }
    }
    assert.Throw();
  });

  it('should install correctly for Linux OS', async () => {
    const version = validVersion;
        
    osTypeStub.returns('Linux');
    
    const installer = new Installer(version);
    await installer.install();

    execExecStub.calledOnceWith(
      path.join(__dirname, 'install-cobol-linux.sh'),
      [ version ]
    );
  });

  itParam('should not install for ${value} OS', fixture, async (osType) => {
    osTypeStub.returns(osType);
    
    const installer = new Installer(validVersion);
    try {
      await installer.install();
    } catch (e) {
      if (e instanceof UnsupportedOSError) {
        assert.isTrue(execExecStub.notCalled);
        return;
      }
    }
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
        return;
      }
    }
    assert.Throw();
  });

  afterEach(() => {
    sinon.restore();
  });
});