Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:41105
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751481Ab2CQKNZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 17 Mar 2012 06:13:25 -0400
Subject: [PATCH 00/02] DA9052 patch series
From: Ashish Jangam <ashish.jangam@kpitcummins.com>
To: <linux-kernel@vger.kernel.org>
CC: Dajun <dajun.chen@diasemi.com>, <linux-watchdog@vger.kernel.org>,
	<lm-sensors@lm-sensors.org>, <sameo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 17 Mar 2012 15:32:53 +0530
Message-ID: <1331978573.7058.68.camel@dhruva>
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFThe following patch series adds support for the ADC functionalit=
y in
MFD and HWMON modules for Dialog Semiconductor DA9052/53 PMICs.

The HWMON patch depends on the ADC patch.

Ashish Jangam (2):
        [MFD]: Incremental patch for ADC support in DA9052/53 MFD
module.
        [HWMON]: HWMON driver for DA9052/53 PMICs. This patch is ACK-by
Guenter Roeck however requires a minor modification.

 Documentation/hwmon/da9052        |   61 +++++++
 drivers/hwmon/Kconfig             |   10 +
 drivers/hwmon/Makefile            |    1 +
 drivers/hwmon/da9052-hwmon.c      |  344
+++++++++++++++++++++++++++++++++++++
 drivers/mfd/da9052-core.c         |  136 +++++++++++++++
 include/linux/mfd/da9052/da9052.h |   20 ++
 6 files changed, 572 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/da9052
 create mode 100644 drivers/hwmon/da9052-hwmon.c
       =20

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
