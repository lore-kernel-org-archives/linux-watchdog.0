Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.phytec.de ([217.6.246.34]:55940 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932919AbcGENYv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 09:24:51 -0400
From: Stefan Christ <s.christ@phytec.de>
To: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [RFC 4/6] i2c-core: add possibility to block an adapter for a single user
Date: Tue, 5 Jul 2016 15:22:21 +0200
Message-Id: <1467724943-13416-5-git-send-email-s.christ@phytec.de>
In-Reply-To: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

TODO use mutex and mutex_try_lock instead of boolean flag. Avoid that
multiple consumers can block the adapter at the same time.

This flag is only intended to be used in the shutdown process in which
no cleanup is required.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/i2c/i2c-core.c | 5 +++++
 include/linux/i2c.h    | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124..9db7130 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2068,6 +2068,11 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	int ret;
 
+	if (adap->blocked) {
+		dev_info(&adap->dev, "No more i2c communication is allowed! pid = %d\n", current->pid);
+		return -EPERM;
+	}
+
 	/* REVISIT the fault reporting model here is weak:
 	 *
 	 *  - When we get an error after receiving N bytes from a slave,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 8461841..282ec71 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -519,6 +519,7 @@ struct i2c_adapter {
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
 	const struct i2c_adapter_quirks *quirks;
+	bool blocked;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
1.9.1

