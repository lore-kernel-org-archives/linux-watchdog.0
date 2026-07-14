Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB900362157;
	Tue, 14 Jul 2026 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026453; cv=none; b=QIUG+c4FY2jxMMcNS41lOB57mNP3gVY9JE6SadsZF6dN4rDhl5Z4LNzIHZXGOvuA6S9Lvl0GoFJPM0zG69GZlO416Df/Jff3AOBFTXKxNbo92mQMHp5FnVq9pDF5uo/TIPRNqOYQyRjR9X0n9Ssg4K0fUhhr120PcbdkFtMrX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026453; c=relaxed/simple;
	bh=16CDVvI8v8rUiyKIYlsQeCWBvnH9t9QtVDzJrB8FhKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNhE3kDiq7II0yDTJ82Cy/YUn3VIx6hNS541n/gS6sC+XsJG6ylE9vt0IhNmr+MDPWk9fxNOX87MQpO/mgqzuF0Ucy8q3bBiFerAYhcOQ+vHDepbK8iaV6tfUqPlOA0VM19ukNSJVMzKxrfdawl4/wP9kuW8Oim07E2VOiWfja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=ke6YA3IC; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ke6YA3IC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
	s=protonmail; t=1784026441; x=1784285641;
	bh=CS+1dFB8UJOePKtsucF3gDIShYHv3uX0v0ENt0alOdc=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ke6YA3IC4puKD5/Zqb56W7ytIj4NVzCzc0smeyx/C+MJRHgQkgPMQwpIsHzePMOwR
	 u5XUtoCgqPy+1mTorjbaoNA+T9e9zE0GNjTLVrTxVRSdl1cBVmPjtinrQeV1dj0KWs
	 NASZ2DvRLA29L4OcSqYSLgizB5wBSlCIumkxNE+cMhdx1dA0L09jbmH5oEv9wJsKO+
	 qqMdGKRifyz8LZHpAg8IQAT0ftgoO8CnI/NC5E/igCKh5OgeJqqcHJXQdoXud1A0+3
	 Nrb5MIH1sGK6DQ7SjvVyPTfTpLqhj2ywMaAIZeGADoBebUK/pqgP1XEnVHSfCMrhGK
	 KAaVF0NouWiTg==
X-Pm-Submission-Id: 4gzx4l2PQsz2Scd5
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2] watchdog: take all OF aliases into account when assigning id
Date: Tue, 14 Jul 2026 12:53:56 +0200
Message-ID: <20260714105356.2931450-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If some, but not all, watchdog devices have device tree aliases, those
without aliases might (depending on probe order) be assigned an id
which would otherwise be assigned to one of those with an alias.

This is problematic when for example watchdog0 is an alias for an
always-running gpio watchdog that userspace must handle, but the SOC's
watchdog device(s) get probed first and thus one of those become
/dev/watchdog0, and then at some point later, the gpio watchdog device
gets probed and becomes /dev/watchdog5.

Ensure that ids for devices without a device tree alias are allocated
from among those where no watchdogX alias exists.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

v2: Allocate dynamic ids from among all non-alias ids, not merely from
above the highest existing alias.  This ensures that if there is no
watchdog0 alias, the first non-aliased watchdog device to get probed
will get id 0, and thus become /dev/watchdog0 and /dev/watchdog.

 drivers/watchdog/watchdog_core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index f4097aefaf49..2293e885cd92 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -240,7 +240,9 @@ EXPORT_SYMBOL_GPL(watchdog_set_restart_priority);
 
 static int ___watchdog_register_device(struct watchdog_device *wdd)
 {
-	int ret, id = -1;
+	int ret, min_id, id = -1;
+	struct device_node *np;
+	char alias[16];
 
 	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
 		return -EINVAL;
@@ -265,8 +267,26 @@ static int ___watchdog_register_device(struct watchdog_device *wdd)
 					     GFP_KERNEL);
 	}
 
-	if (id < 0)
-		id = ida_alloc_max(&watchdog_ida, MAX_DOGS - 1, GFP_KERNEL);
+	/*
+	 * Find an id which is not pre-assigned via a DT alias to some
+	 * other, possibly not yet probed, watchdog device.
+	 */
+	if (id < 0) {
+		np = of_find_node_by_path("/aliases");
+
+		for (min_id = 0; ; min_id = id + 1) {
+			id = ida_alloc_range(&watchdog_ida, min_id, MAX_DOGS - 1,
+					     GFP_KERNEL);
+			if (!np || id < 0)
+				break;
+
+			snprintf(alias, sizeof(alias), "watchdog%d", id);
+			if (!of_get_property(np, alias, NULL))
+				break;
+			ida_free(&watchdog_ida, id);
+		}
+		of_node_put(np);
+	}
 
 	if (id < 0)
 		return id;
-- 
2.55.0

