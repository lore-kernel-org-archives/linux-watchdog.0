Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:51376 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdJWWzz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 23 Oct 2017 18:55:55 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 1/3] watchdog: hpwdt: SMBIOS check
Date: Mon, 23 Oct 2017 16:46:16 -0600
Message-Id: <bd8ad99a9575e3c1df7a73f3b4369785aac56b64.1508797127.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508797127.git.jerry.hoemann@hpe.com>
References: <cover.1508797127.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508797127.git.jerry.hoemann@hpe.com>
References: <cover.1508797127.git.jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This corrects:
commit cce78da76601 ("watchdog: hpwdt: Add check for UEFI bits")

The test on HPE SMBIOS extension type 219 record "Misc Features"
bits for UEFI support is incorrect.  The definition of the Misc Features
bits in the HPE SMBIOS OEM Extensions specification (and related
firmware) was changed to use a different pair of bits to
represent UEFI supported.  Howerver, a corresponding change
to Linux was missed.

Current code/platform work because the iCRU test is working.
But purpose of cce78da766 is to ensure correct functionality
on future systems where iCRU isn't supported.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 67fbe35..9fd869f 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -700,7 +700,7 @@ static void dmi_find_icru(const struct dmi_header *dm, void *dummy)
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

