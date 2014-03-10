Return-Path: <ptyser@xes-inc.com>
From: Peter Tyser <ptyser@xes-inc.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Tyser <ptyser@xes-inc.com>, Guenter Roeck <linux@roeck-us.net>,
        James Ralston <james.d.ralston@intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH 6/8] mfd: lpc_ich: Change Avoton to iTCO v3
Date: Mon, 10 Mar 2014 16:34:56 -0500
Message-Id: <1394487298-14459-6-git-send-email-ptyser@xes-inc.com>
In-Reply-To: <1394487298-14459-1-git-send-email-ptyser@xes-inc.com>
References: <1394487298-14459-1-git-send-email-ptyser@xes-inc.com>
List-ID: <linux-watchdog@vger.kernel.org>

The register layout of the Avoton is compatible with the iTCO v3
register layout.

Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
Tested-by: Rajat Jain <rajatjain@juniper.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: James Ralston <james.d.ralston@intel.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/mfd/lpc_ich.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index b4bfc58..cb655b3 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -502,7 +502,7 @@ static struct lpc_ich_info lpc_chipset_info[] = {
 	},
 	[LPC_AVN] = {
 		.name = "Avoton SoC",
-		.iTCO_version = 1,
+		.iTCO_version = 3,
 	},
 	[LPC_COLETO] = {
 		.name = "Coleto Creek",
-- 
1.7.7.GIT
