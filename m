Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90D3DDDBF
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295527; cv=none; b=JrPz5L3ffeDam2OLr/3E+cPa6iTE6yqpz3paXSlMYZIL/zfsLbbNVzk/tp194JAn3K4pin7Gbibvo9AlSiC6juPH9gF5TYfm9/+om7Txu8hrfSm6FB4fDScDtgrrEiRsqTH1g2eNMiQlO7M8txH0hFkF6u3kxN4IgAVvVySXJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295527; c=relaxed/simple;
	bh=6lHvRBJVTFISgQuhcMFypyadWLPXF+SYk/dEigk1U3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnP0zsZnHsJw4czeLvOdYzPqwUlrTWML9XVM4Kp13/+ea84xysq5cywpoKEMyqmsMr3v7EbVkKCVul8e2CbNSnDjt2Ia4/seNCPUQruOGRZNLX6vAZ8btc2ZBuGSsgvfNuYvnJ5YE/VclTLPw+qcRfvqIVi4gkyBgqUZ8H4lgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxaGkrXG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxaGkrXG"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e4989dacdso4630293e87.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774295523; x=1774900323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5L/uO+Cwo0tKAvA8esxWTY+PEV+J2o8TPXsnbML/a8=;
        b=JxaGkrXGWbiaDEpLGgDy2BtoiH8lIUGwuKlaNFuFPGaIu8aaXrQHOURBlJ/lTSotZL
         h1CrhJMZzIrvZrOrXqw6pDXJfG32Um19gJn3K7ZJtQQ4Ss5IdgUZtT7Ze2KFaRIli1K5
         /emIyP/g81bqeVbY4TyouKfwTWHUFefAisGkS1tkekjN/G1MdHM8ZieHA96xeBUsLNOK
         /zrXXhWiYStQQncA0rEgVm6cDJrYXvopgauLfNuhXnkti5CGq+lrGNVPzgZPfTizmnLP
         +zvIoUi49vuYG/bEPI0Zv1cLuyyB4soNcJHsC2zRcA0O+4u4UaUhYgrAgfLSSpI2OSrc
         OKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774295523; x=1774900323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5L/uO+Cwo0tKAvA8esxWTY+PEV+J2o8TPXsnbML/a8=;
        b=J6+Ya2qiO900Io+TGInT4WYVexWN8XuXsiDTbBt7fu8V7qjPAwFZ+XrpDIvfoNA1nr
         DrAnIYpK7UP3+mY3nB1n2swePx5g6Pdvf0epUKOVNFJYOUK5MyMcn0sPtiV4r/H9Kn1u
         20xc0JuwnE8Ou9ipa2vAYap+fmppIEVF1C2OclnsHe6fUj5MGcKQvrW/S7GNXSz7q4Yc
         1PJoXmuk5/jJfpr9G/T2dRF+qnSNDY1oIwQwHM19IWBz5H5Zg50sAXeRc+gI8Qi5/DoX
         mLLYgYF5Sr+4lT0o9C1HGRyQKaAJGvqDlXpMKnsUbgg4sPZ+1Vh4O6zL0JTtqiqsXneJ
         aEZQ==
X-Gm-Message-State: AOJu0YwbAjFIgpQO5f3lW+G0p6mJkX6bSEuiJfoSigYjowgsmCXZjRfw
	AcqmsJNxahY5lm4yrgMjv6ttNNkYN64RKFPqeZWoGRoRbQ1cfd7QY0mNEl1skd/o
X-Gm-Gg: ATEYQzy+aESIC1NrkzIPLcIkf3/hlAKHDPq20KqUu/lK7d6EC4NRsy/osJrfXVMYjhN
	HzOymyZ6JBAOaUfZ0iOcIVPyTchIFah2bl10i5XRDOQcPJpv8aU9/tKqd/byu8K+oYJsoRMxkU2
	Vdj+DR5k6KLwx3pghZAqCPXHJMjs+FJkMy1Clbpvix1cGSP8aQD3lJ40QypznwtIATpzPE4KKxD
	7kN2+EDtL1Ttcmyma03yuB6rJ2e9ZQjUaLTE1sAMRJjLhdombBcW8q1O8NArV1sMfvborRDNJG4
	w/X4N3jfcYhet/YLT6xKvnEl/H8yazKzalUlL4403+5+H4KKIBIbXyxn91cth2XyY5FzrDYt1hd
	gM5mVsFL53iV5BTiE8PzaXECc2W2mDwF3GJ/Q3MFN5DTzriGbR47m+/6v5x4yn1vFSy8L0oKChD
	y+wQNlDVbVRIGOTBvny9P465uCYMAu9NrrKi+dxcbYphPEpWrwOWu6r/fVe948g8y3WsJIFZMQk
	XKyPBv443dJ0Lquh/K4Je+xdRyd
X-Received: by 2002:a05:6512:32c6:b0:5a1:44ba:c96e with SMTP id 2adb3069b0e04-5a285b6db31mr4256387e87.38.1774295522694;
        Mon, 23 Mar 2026 12:52:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28520734csm2753527e87.53.2026.03.23.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:52:02 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: linux-watchdog@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	ojeda@kernel.org,
	dakr@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	lossin@kernel.org
Subject: [PATCH 2/2] watchdog: softdog_rs: add Rust software watchdog driver
Date: Mon, 23 Mar 2026 22:51:38 +0300
Message-ID: <20260323195138.5541-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323195138.5541-1-iprintercanon@gmail.com>
References: <20260323195138.5541-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust software watchdog driver that uses the new Rust watchdog
abstraction. This demonstrates that the abstraction is functional and
can be used to write real watchdog drivers.

The driver implements start and stop operations. Unlike the C softdog,
this simplified version does not use hrtimers for the actual countdown
-- the watchdog core handles the timeout expiry and keepalive
management. This makes it suitable as a proof-of-concept driver for the
Rust watchdog abstraction.

The driver registers as "Rust Software Watchdog" with a default timeout
of 60 seconds, matching the C softdog's defaults.

The Kconfig option SOFT_WATCHDOG_RS depends on !SOFT_WATCHDOG to
prevent both drivers from being enabled simultaneously.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/watchdog/Kconfig       | 12 +++++
 drivers/watchdog/Makefile      |  1 +
 drivers/watchdog/softdog_rs.rs | 88 ++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/watchdog/softdog_rs.rs

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index d3b9df7d466b0..b7aad39f0de01 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -160,6 +160,18 @@ config SOFT_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called softdog.
 
+config SOFT_WATCHDOG_RS
+	tristate "Rust software watchdog"
+	depends on RUST && !SOFT_WATCHDOG
+	select WATCHDOG_CORE
+	help
+	  A software watchdog driver written in Rust using the Rust watchdog
+	  device abstraction. This is a simplified Rust equivalent of the
+	  C softdog driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called softdog_rs.
+
 config SOFT_WATCHDOG_PRETIMEOUT
 	bool "Software watchdog pretimeout governor support"
 	depends on SOFT_WATCHDOG && WATCHDOG_PRETIMEOUT_GOV
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index ba52099b12539..3039e5068f835 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -239,6 +239,7 @@ obj-$(CONFIG_MAX77620_WATCHDOG) += max77620_wdt.o
 obj-$(CONFIG_NCT6694_WATCHDOG) += nct6694_wdt.o
 obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+obj-$(CONFIG_SOFT_WATCHDOG_RS) += softdog_rs.o
 obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
 obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
diff --git a/drivers/watchdog/softdog_rs.rs b/drivers/watchdog/softdog_rs.rs
new file mode 100644
index 0000000000000..c8ff125e817bc
--- /dev/null
+++ b/drivers/watchdog/softdog_rs.rs
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust software watchdog driver.
+//!
+//! A simplified Rust implementation of the software watchdog, demonstrating
+//! the Rust watchdog device abstraction.
+
+use kernel::prelude::*;
+use kernel::watchdog;
+
+const DEFAULT_MARGIN: u32 = 60;
+const MAX_MARGIN: u32 = 65535;
+
+module! {
+    type: SoftdogModule,
+    name: "softdog_rs",
+    authors: ["Artem Lytkin"],
+    description: "Rust Software Watchdog Device Driver",
+    license: "GPL",
+}
+
+struct SoftdogOps;
+
+#[vtable]
+impl watchdog::WatchdogOps for SoftdogOps {
+    fn start(dev: &mut watchdog::Device) -> Result {
+        pr_info!("watchdog started (timeout={}s)\n", dev.timeout());
+        Ok(())
+    }
+
+    fn stop(_dev: &mut watchdog::Device) -> Result {
+        pr_info!("watchdog stopped\n");
+        Ok(())
+    }
+}
+
+static SOFTDOG_INFO: bindings::watchdog_info = bindings::watchdog_info {
+    options: bindings::WDIOF_SETTIMEOUT
+        | bindings::WDIOF_KEEPALIVEPING
+        | bindings::WDIOF_MAGICCLOSE,
+    firmware_version: 0,
+    identity: {
+        let mut id = [0u8; 32];
+        let s = b"Rust Software Watchdog";
+        let mut i = 0;
+        while i < s.len() {
+            id[i] = s[i];
+            i += 1;
+        }
+        id
+    },
+};
+
+static mut SOFTDOG_OPS: bindings::watchdog_ops =
+    watchdog::create_watchdog_ops::<SoftdogOps>();
+
+struct SoftdogModule {
+    _reg: watchdog::Registration,
+}
+
+impl kernel::Module for SoftdogModule {
+    fn init(module: &'static ThisModule) -> Result<Self> {
+        // SAFETY: SOFTDOG_OPS is only mutated here, before registration,
+        // and this function is called exactly once during module init.
+        let ops = unsafe { &mut *core::ptr::addr_of_mut!(SOFTDOG_OPS) };
+
+        let reg = watchdog::Registration::register(
+            module,
+            None,
+            &SOFTDOG_INFO,
+            ops,
+            DEFAULT_MARGIN,
+            1,
+            MAX_MARGIN,
+            false,
+        )?;
+
+        pr_info!("initialized (timeout={}s)\n", DEFAULT_MARGIN);
+
+        Ok(SoftdogModule { _reg: reg })
+    }
+}
+
+impl Drop for SoftdogModule {
+    fn drop(&mut self) {
+        pr_info!("exit\n");
+    }
+}
-- 
2.43.0

