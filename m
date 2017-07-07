Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v4 0/2] Add ASPEED watchdog device tree properties
Date: Thu,  6 Jul 2017 19:48:58 -0500
Message-Id: <20170707004901.26780-1-cbostic@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>

Document device tree optional properties for ASPEED watchdog.
Reference properties in ASPEED watchdog driver and configure accordingly.

Christopher Bostic (2):
  drivers/watchdog: Add optional ASPEED device tree properties
  drivers/watchdog: ASPEED reference dev tree properties for config

 .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 35 ++++++++++++++++++++++
 drivers/watchdog/aspeed_wdt.c                      | 27 +++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)

-- 
1.8.2.2
