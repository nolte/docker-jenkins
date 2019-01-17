import pytest
import subprocess
import testinfra
import time


# scope='session' uses the same container for all the tests;
# scope='function' uses a new container per test function.
@pytest.fixture(scope='session')
def host(request):
    # build local ./Dockerfile
    subprocess.check_call(['docker', 'build', '-t', 'myimage', '.'])
    # run a container
    docker_id = subprocess.check_output(
        ['docker', 'run', '-d', 'myimage']).decode().strip()
    # return a testinfra connection to the container
    yield testinfra.get_host("docker://" + docker_id)
    # at the end of the test suite, destroy the container
    subprocess.check_call(['docker', 'rm', '-f', docker_id])


testdata = [
    "v1.13.0",
    "v1.6.1",
    "v1.4.0"
]
@pytest.mark.parametrize("version", testdata)
def test_check_install_kubectl(host, version):
    versionBin = host.file("/opt/kubectl/"+version+"/kubectl")
    assert versionBin.exists
    assert versionBin.mode == 484

testdataOC = [
    ("v3.11.0",484),
    ("v3.6.0",484)
]
@pytest.mark.parametrize("versionOC,expectedMode", testdataOC)
def test_check_install_oc(host, versionOC, expectedMode):
    versionBin = host.file("/opt/openshift-origin-client-tools/"+versionOC+"/oc")
    assert versionBin.exists
    assert versionBin.mode == expectedMode

testdataOC = [
    ("v1.0.11",484)
]
@pytest.mark.parametrize("versionOC,expectedMode", testdataOC)
def test_check_install_kustomize(host, versionOC, expectedMode):
    versionBin = host.file("/opt/kustomize/"+versionOC+"/kustomize")
    assert versionBin.exists
    assert versionBin.mode == expectedMode


testdataOC = [
    ("v0.11.11",484)
]
@pytest.mark.parametrize("versionOC,expectedMode", testdataOC)
def test_check_install_terraform(host, versionOC, expectedMode):
    versionBin = host.file("/opt/terraform/"+versionOC+"/terraform")
    assert versionBin.exists
    assert versionBin.mode == expectedMode
