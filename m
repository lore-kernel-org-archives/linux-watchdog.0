Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:46987 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbbC1SGH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 28 Mar 2015 14:06:07 -0400
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Wim Van Sebroeck <wim@iguana.be>,
	David Daney <david.daney@cavium.com>,
	linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] watchdog: octeon: use fixed length string for register names
Date: Sat, 28 Mar 2015 20:05:40 +0200
Message-Id: <1427565940-22951-3-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use fixed length string for register names. This saves 416 bytes
in text size.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/watchdog/octeon-wdt-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 728840c..14521c8 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -304,7 +304,7 @@ static void octeon_wdt_write_hex(u64 value, int digits)
 	}
 }
 
-static const char *reg_name[] = {
+static const char reg_name[][3] = {
 	"$0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
 	"a4", "a5", "a6", "a7", "t0", "t1", "t2", "t3",
 	"s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
-- 
2.2.0

