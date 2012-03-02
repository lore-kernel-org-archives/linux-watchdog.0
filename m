Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:13318
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965148Ab2CBOhk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 Mar 2012 09:37:40 -0500
Subject: [PATCH 00/03] DA9052 patch series
From: Ashish Jangam <ashish.jangam@kpitcummins.com>
To: <linux-kernel@vger.kernel.org>
CC: Dajun <dajun.chen@diasemi.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	<linux-watchdog@vger.kernel.org>, <lm-sensors@lm-sensors.org>,
	<sameo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 2 Mar 2012 19:58:36 +0530
Message-ID: <1330698516.21817.29.camel@dhruva>
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFThe following patch series adds support for the ADC functionalit=
y in MFD core
module, the HWMON module and the ONKEY module for Dialog Semiconductor
DA9052/53 PMICs.

The HWMON patch depends on the patch for ADC functionality in MFD module.

Ashish Jangam (2):
	[MFD]: Incremental with ADC support. HWMON patch also depends on this.
	[HWMON]: HWMON driver for DA9052/53 PMICs.
	[ONKEY]: ONKEY driver for DA9052/53 PMICs.

 Documentation/hwmon/da9052        |   61 +++++++
 drivers/hwmon/Kconfig             |   10 +
 drivers/hwmon/Makefile            |    1 +
 drivers/hwmon/da9052-hwmon.c      |  344 +++++++++++++++++++++++++++++++=
++++++
 drivers/input/misc/Kconfig        |   10 +
 drivers/input/misc/Makefile       |    1 +
 drivers/input/misc/da9052_onkey.c |  174 +++++++++++++++++++
 drivers/mfd/da9052-core.c         |  136 +++++++++++++++
 include/linux/mfd/da9052/da9052.h |   20 ++
 9 files changed, 757 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/da9052
 create mode 100644 drivers/hwmon/da9052-hwmon.c
 create mode 100644 drivers/input/misc/da9052_onkey.c





This message contains information that may be privileged or confidential =
and is the property of the KPIT Cummins Infosystems Ltd. It is intended o=
nly for the person to whom it is addressed. If you are not the intended r=
ecipient, you are not authorized to read, print, retain copy, disseminate=
, distribute, or use this message or any part thereof. If you receive thi=
s message in error, please notify the sender immediately and delete all c=
opies of this message. KPIT Cummins Infosystems Ltd. does not accept any =
liability for virus infected mails.


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
