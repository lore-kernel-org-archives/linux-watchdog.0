Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:38002 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbdJTXEi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 20 Oct 2017 19:04:38 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 2/3] watchdog: hpwdt: SMBIOS check
Date: Fri, 20 Oct 2017 16:54:49 -0600
Message-Id: <edf5fbe55bc25680926f1526145584bd33b05ff3.1508539271.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508539271.git.jerry.hoemann@hpe.com>
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508539271.git.jerry.hoemann@hpe.com>
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Correct test on SMBIOS table 219 Misc Features bits for UEFI supported.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ef54b03..4c011e8 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -707,7 +707,7 @@ static void dmi_find_icru(const struct dmi_header *dm, void *dummy)
 		smbios_proliant_ptr = (struct smbios_proliant_info *) dm;
 		if (smbios_proliant_ptr->misc_features & 0x01)
 			is_icru = 1;
-		if (smbios_proliant_ptr->misc_features & 0x408)
+		if (smbios_proliant_ptr->misc_features & 0x1400)
 			is_uefi = 1;
 	}
 }
-- 
1.8.3.1

