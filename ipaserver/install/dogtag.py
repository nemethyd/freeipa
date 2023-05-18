#
# Copyright (C) 2016  FreeIPA Contributors see COPYING for license
#

"""
Dogtag-based service installer module
"""

from ipalib.install import service
from ipalib.install.service import prepare_only, replica_install_only
from ipapython.install.core import knob
from ipaserver.install.dogtaginstance import PKIIniLoader


class DogtagInstallInterface(service.ServiceInstallInterface):
    """
    Interface common to all Dogtag-based service installers
    """

    ca_file = knob(
        str, None,
        description="location of CA PKCS#12 file",
        cli_metavar='FILE',
    )
    ca_file = prepare_only(ca_file)
    ca_file = replica_install_only(ca_file)

    pki_config_override = knob(
        str, None,
        cli_names='--pki-config-override',
        description="Path to ini file with config overrides.",
    )

    @pki_config_override.validator
    def pki_config_override(self, value):
        if value is not None:
            PKIIniLoader.verify_pki_config_override(value)
    
    ca_install_port = knob(
        int, 8080,
        description="the dogtag web port (defaults to 8080).",
        cli_names='--ca-install-port',
        cli_metavar = 'PORT'
    )

    @ca_install_port.validator
    def ca_install_port(self, value):
        if value < 1:
            raise ValueError("expects an integer greater than 0.")
