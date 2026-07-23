Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC44C77AC
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823369; cv=none; b=OX6ZHcdSGJOEINUC4yLFapK7T+7Mnds8jVa+w1yk446xFkKcYn62hrm4T4IMU9iLJIa/xccwg/u52uV+DuQezKsIoamqjJscplSE2o+T9X/nYMP8blFS4Alw9lDZmsL1X1LYcgwPrFYT/WSlO3qJ5f0jUOwqRwO1Pj1yzCjdiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823369; c=relaxed/simple;
	bh=aF9Eskw4wP/Mk/gPSa+pEH/ArdSYufriaP9yc1cpeXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7Udmv+WAt/jAHdlYQlr48cWZqSKuOFjUQMxqpPKx1YlsESljBugto/5HmzPRZptLkjHpb8VOGyQZ2yAz435WVKeyWgGZCrehdfXYj3QOowFg6uO0w/eqJkV+Voc/jB9JMraq2DdWoHmeKH5Waq1p5q6+Uiha/DpAklDMFm6LGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhXUGKDn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhXUGKDn"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so547652e87.0
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823356; x=1785428156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WSFkoNus/+V1J3x0Yh+fiQrb5iWsjELtWkobo5nQNog=;
        b=YhXUGKDnYPOidm1tunISKVa8tG5krDw3PGbI0TrgM3XCrpwHXRtDymperxSuyQRnGj
         HSV2YrfKo1N+dwTK8b48HOwTW6DuVy9S67wUq30n97Ax2nie9WV9ln5NNLZNFQckHlry
         wR9u16NGY1Ob2KXL5KysaH1+Gh5YjIB7AcQW50d5ch9ctjQfWN3YmUTQEY3XnT/m1wZr
         18tpfQVjDo2AaC8mad+xwM8UoaBbXOsiyxaDkr0YW+K3yjM43+DM4P/z6+SyGTDLuyRE
         AH4fooC+vZLaGc48tHLS8C+jfqnu0Q0tpYKL4eNOqmcBoiH4cfuD7CP7bKr7GMwLMxv7
         gpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823356; x=1785428156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WSFkoNus/+V1J3x0Yh+fiQrb5iWsjELtWkobo5nQNog=;
        b=LxNnVglCOGhn5NeWWvmPW691ilpP+kMokaqSuIHl/9ulxTFHzwMD1rQ2UtkWwIcbSb
         ayI78q4Tf6tKm4KN+iCVfqztSLtFwO97JC81wmrA7XmcGNBto1pBlAPn5G6trvtxuKji
         dmYYV30h6sgTZaS+jJq7wrbR44SJcRaypw2q+4NuAZYyFgbq/5AF5L/gSKYxmigLMPJj
         IAnPhdzQ2rlZXa72mqR2jR3yp/y5cS/FqCNqjgU7ISfDIeMpb/nTSxW5cWQTqnqfSPmk
         mmvCXAYfDjN/aE7e2T5WYnx1AO3eGED998leQa/Q4WH7GUJhkoz6MCK2OQvk7rfhoBL4
         de7w==
X-Gm-Message-State: AOJu0Yyfr9wo5T6A7chJfR5Bk3HRnpaBotmh9EHui0gNa1WCX06kV6rP
	zj6ghXzreIiiR1I/1jioIoJHQL4sdABiqiUjkK6R2n99jbQwNoh5+BcegKu/oYLpvEk=
X-Gm-Gg: AR+sD13sdQ4NRsXyoWCCQ7NzJwLf/MmapkUdFSLNVarBvuDB4R7CiaF7NxYRa7VmQN+
	JK5Ucqan0h6Sf/bUArAeIZ2EHroh8qym5SRnMGsfx4AoZ5bufOTFCxCwmE0lM3Qx4S4h39/puM0
	Rer+yFgcdp1ngVuWgAmAhysfDDtPG37ajoWyegRQyQ/+fSZHfeioTRb4hYFbS4II+WgLHg3GXp/
	kUO99hAn4+q4Z9uCghZugH6WzTeGq3Wy6vcHSyXdtMta3vihXuxtWNKz245ct3egOagIIsjehtM
	lB1FgfKqVFOI5hknQ8xv1c1uDIFpGUPgVlQp47p61Yvky/sZnvWWpmjeTZaEHYzlBLYVZTeJ2W3
	joaXWrln656b9kakgXxFi6jWZVX3vV1X2bG1pTXPrdA8YK9jcT0yicn8k57uox9B6ECtqM/OGMc
	gEjQk2l9RxHQ7loVPme3QFu0+W89GUWjc8uV/iRBMBCwSV+N90Cg1wp8/GNKYuzOIf4EfaWJA+d
	4OL
X-Received: by 2002:a05:6512:3d21:b0:5b1:5fe4:6f64 with SMTP id 2adb3069b0e04-5b2b2f77bddmr912875e87.45.1784823355629;
        Thu, 23 Jul 2026 09:15:55 -0700 (PDT)
Received: from localhost.localdomain (46-138-176-102.dynamic.spd-mgts.ru. [46.138.176.102])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6d8c40fsm9875561fa.41.2026.07.23.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:15:55 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: linux-watchdog@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	ojeda@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	dakr@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	lossin@kernel.org
Subject: [PATCH v2 3/3] watchdog: softdog_rs: add Rust software watchdog driver
Date: Thu, 23 Jul 2026 19:15:29 +0300
Message-ID: <20260723161529.23759-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723161529.23759-1-iprintercanon@gmail.com>
References: <20260723161529.23759-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust software watchdog driver using the Rust watchdog
abstraction, functionally equivalent to the core of the C softdog
driver.

An hrtimer is armed on start and re-armed on every keepalive ping for
the currently configured timeout. If userspace stops pinging, the
timer expires and the system is restarted via emergency_restart(),
matching the C softdog default behaviour. Stopping the watchdog
cancels the timer. The timer handle is protected by a mutex since
watchdog callbacks may run concurrently.

Two implementation notes:

  - Re-arming cancels the previous timer before starting it again
    (the hrtimer handle API cancels on drop), so a ping can briefly
    block on a concurrently firing callback and there is a tiny
    disarmed window during re-arm. A future handle restart API would
    eliminate this.

  - The C softdog pins the module manually while the timer is armed;
    this driver gets equivalent protection from the watchdog core,
    which holds the module reference while the device is open or the
    hardware watchdog is marked running, so module unload is blocked
    while the timer is armed.

The timeout is adjustable from userspace via WDIOC_SETTIMEOUT; since
the driver has no set_timeout operation, the watchdog core updates the
timeout directly and the new value takes effect on the next ping.

The Kconfig option uses SOFT_WATCHDOG=n (rather than !SOFT_WATCHDOG,
which would still allow both as modules) so that the C and Rust
software watchdogs are mutually exclusive.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/watchdog/Kconfig       |  12 +++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/softdog_rs.rs | 143 +++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 drivers/watchdog/softdog_rs.rs

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08cb8612d41fe..7dcbb285c6f16 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -160,6 +160,18 @@ config SOFT_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called softdog.
 
+config SOFT_WATCHDOG_RS
+	tristate "Rust software watchdog"
+	depends on RUST && SOFT_WATCHDOG=n
+	select WATCHDOG_CORE
+	help
+	  A software watchdog driver written in Rust using the Rust watchdog
+	  device abstraction. This is a Rust equivalent of the C softdog
+	  driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called softdog_rs.
+
 config SOFT_WATCHDOG_PRETIMEOUT
 	bool "Software watchdog pretimeout governor support"
 	depends on SOFT_WATCHDOG && WATCHDOG_PRETIMEOUT_GOV
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index bc1d52220f223..397b16d648eca 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -236,6 +236,7 @@ obj-$(CONFIG_MAX77620_WATCHDOG) += max77620_wdt.o
 obj-$(CONFIG_NCT6694_WATCHDOG) += nct6694_wdt.o
 obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+obj-$(CONFIG_SOFT_WATCHDOG_RS) += softdog_rs.o
 obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
 obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
diff --git a/drivers/watchdog/softdog_rs.rs b/drivers/watchdog/softdog_rs.rs
new file mode 100644
index 0000000000000..45fd76c4fd195
--- /dev/null
+++ b/drivers/watchdog/softdog_rs.rs
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust software watchdog driver.
+//!
+//! A software watchdog implemented with an hrtimer: when the timer expires
+//! before the next keepalive ping, the system is restarted.
+//!
+//! C version of this driver:
+//! [`drivers/watchdog/softdog.c`](srctree/drivers/watchdog/softdog.c)
+
+use kernel::{
+    impl_has_hr_timer, new_mutex,
+    prelude::*,
+    reboot,
+    sync::{Arc, ArcBorrow, Mutex},
+    time::{
+        hrtimer::{
+            ArcHrTimerHandle, HrTimer, HrTimerCallback, HrTimerCallbackContext, HrTimerPointer,
+            HrTimerRestart, RelativeMode,
+        },
+        Delta, Monotonic,
+    },
+    watchdog::{self, flags},
+};
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
+/// The countdown state: the hrtimer and the handle of its last arming.
+///
+/// Watchdog callbacks may run concurrently (for example the reboot notifier
+/// `stop` against an in-flight ioctl), so the handle is protected by a
+/// mutex.
+#[pin_data]
+struct Softdog {
+    #[pin]
+    timer: HrTimer<Self>,
+    #[pin]
+    handle: Mutex<Option<ArcHrTimerHandle<Softdog>>>,
+}
+
+impl Softdog {
+    fn new() -> impl PinInit<Self> {
+        pin_init!(Self {
+            timer <- HrTimer::new(),
+            handle <- new_mutex!(None),
+        })
+    }
+
+    /// (Re)arms the countdown to fire in `timeout` seconds.
+    fn arm(this: &Arc<Self>, timeout: u32) {
+        let mut guard = this.handle.lock();
+        // Drop the previous handle first: dropping a handle cancels the
+        // timer, so this must not happen after the new arming.
+        *guard = None;
+        *guard = Some(this.clone().start(Delta::from_secs(i64::from(timeout))));
+    }
+
+    /// Cancels the countdown.
+    fn disarm(this: &Arc<Self>) {
+        // Dropping the handle cancels the timer and also breaks the
+        // reference cycle `Softdog -> handle -> Arc<Softdog>`.
+        *this.handle.lock() = None;
+    }
+}
+
+impl_has_hr_timer! {
+    impl HasHrTimer<Self> for Softdog {
+        mode: RelativeMode<Monotonic>, field: self.timer
+    }
+}
+
+impl HrTimerCallback for Softdog {
+    type Pointer<'a> = Arc<Self>;
+
+    fn run(_this: ArcBorrow<'_, Self>, _ctx: HrTimerCallbackContext<'_, Self>) -> HrTimerRestart {
+        pr_crit!("Initiating system reboot\n");
+        reboot::emergency_restart();
+        // Only reached if the machine failed to restart.
+        HrTimerRestart::NoRestart
+    }
+}
+
+struct SoftdogOps;
+
+#[vtable]
+impl watchdog::WatchdogOps for SoftdogOps {
+    type Data = Arc<Softdog>;
+
+    fn start(dev: &watchdog::Device, data: &Arc<Softdog>) -> Result {
+        Softdog::arm(data, dev.timeout());
+        Ok(())
+    }
+
+    fn ping(dev: &watchdog::Device, data: &Arc<Softdog>) -> Result {
+        Softdog::arm(data, dev.timeout());
+        Ok(())
+    }
+
+    fn stop(_dev: &watchdog::Device, data: &Arc<Softdog>) -> Result {
+        Softdog::disarm(data);
+        Ok(())
+    }
+}
+
+static SOFTDOG_INFO: watchdog::Info = watchdog::Info::new(
+    flags::SETTIMEOUT | flags::KEEPALIVEPING | flags::MAGICCLOSE,
+    "Rust Software Watchdog",
+);
+
+struct SoftdogModule {
+    _reg: watchdog::Registration<SoftdogOps>,
+}
+
+impl kernel::Module for SoftdogModule {
+    fn init(module: &'static ThisModule) -> Result<Self> {
+        let data = Arc::pin_init(Softdog::new(), GFP_KERNEL)?;
+
+        let options = watchdog::Options {
+            timeout: DEFAULT_MARGIN,
+            min_timeout: 1,
+            max_timeout: MAX_MARGIN,
+            // Stop the countdown on reboot so that an orderly reboot is not
+            // interrupted by the watchdog firing, like the C softdog does.
+            stop_on_reboot: true,
+            ..Default::default()
+        };
+
+        let reg = watchdog::Registration::register(module, None, &SOFTDOG_INFO, &options, data)?;
+
+        pr_info!("initialized (timeout={}s)\n", DEFAULT_MARGIN);
+
+        Ok(SoftdogModule { _reg: reg })
+    }
+}
-- 
2.43.0

