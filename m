Return-path: <xypron.glpk@gmx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] watchdog: pcipcwd_show_card_info: wrong format string
Date: Sat,  5 Nov 2016 15:50:28 +0100
Message-Id: <20161105145028.4894-1-xypron.glpk@gmx.de>
List-ID: <linux-watchdog@vger.kernel.org>

fw_rev_major and fw_rev_minor are defined as int.
Use %d to print them.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/watchdog/pcwd_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index c0d07ee..e1fbbf6 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -234,7 +234,7 @@ static void pcipcwd_show_card_info(void)
 	got_fw_rev = send_command(CMD_GET_FIRMWARE_VERSION, &fw_rev_major,
 								&fw_rev_minor);
 	if (got_fw_rev)
-		sprintf(fw_ver_str, "%u.%02u", fw_rev_major, fw_rev_minor);
+		sprintf(fw_ver_str, "%d.%02d", fw_rev_major, fw_rev_minor);
 	else
 		sprintf(fw_ver_str, "<card no answer>");
 
-- 
2.10.1
