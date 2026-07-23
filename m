Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E322472F8B
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823375; cv=none; b=JVV6AG3ui3gRJuVVJ0zT+9tnplpzizrM6P6xYQcsbW+FOLNdNyLadbxWwVReevi301rRCR3Kivb5oFlBTAZYMPki6Fl7YjciQQj1SC3H7pwBa/SEY3h4kOuDl8yGXTXiXmSVRvyH/xgdNP5EvlL9Okv28hY6TkmhZaHSCIvGJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823375; c=relaxed/simple;
	bh=Nc16yMP7bKLgpTlJCafYhThY7V5BbPQMQQCfT008bao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtZfNWQS2X970a6wGHzO5Mg+iOUswqPz7Cq7SNJj8SKbdSp8ml2Eo7e7/g+tnczuA3jkLGoyVTnZ91imjPvMEU4Oz7PawUDYRXKY4gNKNeMIhgL/0ZNOOMoAr3bKmCq2yKy1+mmr+ICWqWM2OE1nsBGp1L2DBHNIabX+JmYexk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIRgTSLJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIRgTSLJ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c923b8c2aso8846861fa.2
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823354; x=1785428154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GC2pBU7SWAmu3jI5sN/Z9z0x7aU14fmy5WI7sRRsOcQ=;
        b=RIRgTSLJ8iRlI74PE/9sPCQC9RX2ByuOcAHfHkeI11e8NppxDY61ZBjSMdF7NzGDNH
         K/EiNxjYhR/twDx/V/fdPZbTe2cfoyaXZaMa2gf1rN8WajHXithJZt9CwBiXOsnQgbDS
         8T23Q68kfrrj7npQTZkbIwbXDQZIvkpw1qwOd5IxB4GVWO3VyzN+FoKToNvmfwGv1pyT
         rDJU2r7Ojg0ztf3zj3fbbmGBbquIx8032MrPSpYrIFtRTTVrakhRNQ/W2b8qaRwOT89W
         LoBN9OvkTjKIpSkrkWae78IvaDen8a0XtNxemahfFgZF4oSjGEVx7LZG42g3RdBCucrY
         ZZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823354; x=1785428154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GC2pBU7SWAmu3jI5sN/Z9z0x7aU14fmy5WI7sRRsOcQ=;
        b=ix38KlqBbeOysf+TkJAGNT1Y75lSWaxCm5Unq4ZNVDYg4l/RthdDy4Ma8g0ccsl8Y9
         xvDnfoK08umdOWSn+1Y4z62n7VzLyePpDtrLeWXBcub1iur+P6ZXgzFO7kzzPRpafILk
         SXuuDJqD5pYoTgkQ4rAQc4r+96mOZv/25igpcUekwvR7vn4nt9qJ8z8FaxSxKT5POTV7
         sGSnq/mIz5lTEGn/tGosVbNMCzGFMSqgU+1t4sL/gJoeR5MRDOjgRP6XbirJxuQkUead
         mLZM7w8bFmhRQYGyKXRsBaODW5VGitDVIy0hd8UxgB8LFVD4N6RBMmBnGxzAP1dDpXPF
         fsvw==
X-Gm-Message-State: AOJu0YyRrniAvvSI6B6QaSKUaU+IxvzwHDaO5yfmWcQRhJhsY2hwYGNb
	LlXPcXKZUleltmeu+D7SdbZL9ybQcO309ZX82HYOkD6u9b4oUZMbyqC+UBm6mxh7Fmg=
X-Gm-Gg: AR+sD11ha0+FCEWRFXIZKJcDiSYXXASi9f2kW2UEuXjgSve8pz2pdwCMu8LdytSJOEJ
	jnw2Dj3r1N0sySfnbG8kHeV6jAB4SNVae3s9UqVhkEGpJy1Yi/be/DXr0Ul2FaOGxYWfjfESmf7
	QetF9nU99KU3SjJLZIJ3Ajw7ZCiWeWCqet0Mpa8ldt/RyDArzHY8Z4eEDmq3DF8TAaSpWXeYEba
	Iy/0/SPykbfbi+F350sm2iNA4EMXrT93VY2+hO+9g1CqnH1kHzxd0T1t3/WaIRYGEWnlydDNpDY
	rHOOi/BQw2JU1aVxt0qKMUzXDzBFie0+TCkCr82v5FBEupyOLeqqDNI1sb6MxbK2UwgFRXxosfb
	5KHXpDhdlurAAAVqK4CTM63ajvHdFWCP/9IX7ePpEBylrR+/8vUWVKwVSWXHhJZpyj9C1ylDXqZ
	iVdunMI0Rvabn4YEvPHGd3DEhM86BkyKhco0YLrLSUY4QgOKih7iEYBFwRlgn0QceaGBVvek7dq
	GhD4/OOOtJjFN0=
X-Received: by 2002:a05:651c:a05:b0:38f:20cc:2bb0 with SMTP id 38308e7fff4ca-39f07f10d7dmr8127071fa.23.1784823353528;
        Thu, 23 Jul 2026 09:15:53 -0700 (PDT)
Received: from localhost.localdomain (46-138-176-102.dynamic.spd-mgts.ru. [46.138.176.102])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6d8c40fsm9875561fa.41.2026.07.23.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:15:53 -0700 (PDT)
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
Subject: [PATCH v2 1/3] rust: watchdog: add watchdog device abstraction
Date: Thu, 23 Jul 2026 19:15:27 +0300
Message-ID: <20260723161529.23759-2-iprintercanon@gmail.com>
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

Add Rust abstractions for the Linux watchdog subsystem, enabling
watchdog drivers to be written in Rust:

  - A `Device` wrapper around `struct watchdog_device` providing
    accessors for timeout, pretimeout, and status fields.

  - An `Info` wrapper around `struct watchdog_info` with a const
    constructor, plus option flags in the `flags` module, so drivers do
    not need to touch raw bindings.

  - An `Options` struct describing timeouts, `max_hw_heartbeat_ms`,
    `nowayout` (defaulting to CONFIG_WATCHDOG_NOWAYOUT), and
    `stop_on_reboot` policy.

  - A `#[vtable] WatchdogOps` trait with an associated `Data` type for
    driver private data. `start()` is mandatory; `stop()`, `ping()`,
    `set_timeout()`, `set_pretimeout()`, and `get_timeleft()` are
    optional.

  - A generic `Registration<T>` that owns the `watchdog_device`, the
    `watchdog_ops` (with `owner` set from `ThisModule` for correct
    module refcounting), and the driver data in a single heap
    allocation, so no static mutable state is needed in drivers and
    multiple device instances are naturally supported.

The watchdog core does not hold its lock on every callback path (the
first start/ping on open, the reboot notifier stop, and the stop on
unregistration run without it), so callbacks receive only shared
references and the driver data must be Sync; mutable driver state
needs its own synchronisation.

The watchdog is configured to stop on unregistration so that a
stoppable watchdog does not keep running unattended. Requesting
stop_on_reboot without a stop() implementation is rejected with EINVAL
since the core would only warn and skip the notifier.

Also add C helper functions (marked __rust_helper) for the inline
watchdog functions, include linux/watchdog.h in the bindings helper
header, and add the new files to the WATCHDOG DEVICE DRIVERS section
of MAINTAINERS.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 MAINTAINERS                     |   2 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/watchdog.c         |  38 +++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/watchdog.rs         | 522 ++++++++++++++++++++++++++++++++
 6 files changed, 566 insertions(+)
 create mode 100644 rust/helpers/watchdog.c
 create mode 100644 rust/kernel/watchdog.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab8736850ea3..214d92057c447 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29027,6 +29027,8 @@ F:	drivers/watchdog/
 F:	include/linux/watchdog.h
 F:	include/trace/events/watchdog.h
 F:	include/uapi/linux/watchdog.h
+F:	rust/helpers/watchdog.c
+F:	rust/kernel/watchdog.rs
 
 WAVE5 VPU CODEC DRIVER
 M:	Nas Chung <nas.chung@chipsnmedia.com>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b3..e692d142c8608 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -91,6 +91,7 @@
 #include <linux/tracepoint.h>
 #include <linux/usb.h>
 #include <linux/wait.h>
+#include <linux/watchdog.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
 #include <trace/events/rust_sample.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 998e31052e660..b670a315a8cca 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -98,5 +98,6 @@
 #include "usb.c"
 #include "vmalloc.c"
 #include "wait.c"
+#include "watchdog.c"
 #include "workqueue.c"
 #include "xarray.c"
diff --git a/rust/helpers/watchdog.c b/rust/helpers/watchdog.c
new file mode 100644
index 0000000000000..0d92e4bec0526
--- /dev/null
+++ b/rust/helpers/watchdog.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/watchdog.h>
+
+__rust_helper bool rust_helper_watchdog_active(const struct watchdog_device *wdd)
+{
+	return watchdog_active(wdd);
+}
+
+__rust_helper bool rust_helper_watchdog_hw_running(const struct watchdog_device *wdd)
+{
+	return watchdog_hw_running(wdd);
+}
+
+__rust_helper void rust_helper_watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
+{
+	watchdog_set_nowayout(wdd, nowayout);
+}
+
+__rust_helper void rust_helper_watchdog_stop_on_reboot(struct watchdog_device *wdd)
+{
+	watchdog_stop_on_reboot(wdd);
+}
+
+__rust_helper void rust_helper_watchdog_stop_on_unregister(struct watchdog_device *wdd)
+{
+	watchdog_stop_on_unregister(wdd);
+}
+
+__rust_helper void rust_helper_watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
+{
+	watchdog_set_drvdata(wdd, data);
+}
+
+__rust_helper void *rust_helper_watchdog_get_drvdata(struct watchdog_device *wdd)
+{
+	return watchdog_get_drvdata(wdd);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df2..a1130c4b82881 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -134,6 +134,8 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+#[cfg(CONFIG_WATCHDOG)]
+pub mod watchdog;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/watchdog.rs b/rust/kernel/watchdog.rs
new file mode 100644
index 0000000000000..155eecc679238
--- /dev/null
+++ b/rust/kernel/watchdog.rs
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Watchdog device support.
+//!
+//! C headers: [`include/linux/watchdog.h`](srctree/include/linux/watchdog.h).
+
+use crate::{bindings, device, error::*, prelude::*, types::Opaque};
+use core::marker::PhantomData;
+
+/// A watchdog device.
+///
+/// Wraps the kernel's [`struct watchdog_device`].
+///
+/// # Invariants
+///
+/// The pointer is valid for the duration of a callback invocation.
+///
+/// # Concurrency
+///
+/// The watchdog core serialises most operations via its internal lock, but
+/// not all of them: the first `start`/`ping` on open, the reboot notifier
+/// `stop`, and the `stop` on unregistration run without it. Therefore only
+/// shared references are handed to drivers, all mutation goes through
+/// interior mutability, and driver data must be [`Sync`].
+///
+/// [`struct watchdog_device`]: srctree/include/linux/watchdog.h
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::watchdog_device>);
+
+impl Device {
+    /// Creates a new [`Device`] reference from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` must point at a valid `watchdog_device`.
+    /// - The returned reference must not outlive the callback invocation.
+    unsafe fn from_raw<'a>(ptr: *mut bindings::watchdog_device) -> &'a Self {
+        // CAST: `Self` is a `repr(transparent)` wrapper around
+        // `bindings::watchdog_device`.
+        let ptr = ptr.cast::<Self>();
+        // SAFETY: By the function requirements the pointer is valid.
+        unsafe { &*ptr }
+    }
+
+    /// Returns a raw pointer to the underlying `watchdog_device`.
+    fn as_raw(&self) -> *mut bindings::watchdog_device {
+        self.0.get()
+    }
+
+    /// Returns the current timeout in seconds.
+    pub fn timeout(&self) -> u32 {
+        // SAFETY: The struct invariant ensures the pointer is valid. The
+        // read of this `unsigned int` field mirrors how the C core and C
+        // drivers access it without synchronisation.
+        unsafe { (*self.as_raw()).timeout }
+    }
+
+    /// Sets the current timeout in seconds.
+    pub fn set_timeout(&self, timeout: u32) {
+        // SAFETY: The struct invariant ensures the pointer is valid. The
+        // field lives in an `Opaque`, so writing through a shared reference
+        // is allowed; the C core accesses this field the same way.
+        unsafe { (*self.as_raw()).timeout = timeout };
+    }
+
+    /// Returns the current pretimeout in seconds.
+    pub fn pretimeout(&self) -> u32 {
+        // SAFETY: See `timeout`.
+        unsafe { (*self.as_raw()).pretimeout }
+    }
+
+    /// Returns the minimum timeout in seconds.
+    pub fn min_timeout(&self) -> u32 {
+        // SAFETY: See `timeout`.
+        unsafe { (*self.as_raw()).min_timeout }
+    }
+
+    /// Returns the maximum timeout in seconds.
+    pub fn max_timeout(&self) -> u32 {
+        // SAFETY: See `timeout`.
+        unsafe { (*self.as_raw()).max_timeout }
+    }
+
+    /// Returns `true` if the watchdog is active.
+    pub fn is_active(&self) -> bool {
+        // SAFETY: The struct invariant ensures the pointer is valid.
+        unsafe { bindings::watchdog_active(self.as_raw()) }
+    }
+
+    /// Returns `true` if the hardware watchdog is running.
+    pub fn is_hw_running(&self) -> bool {
+        // SAFETY: The struct invariant ensures the pointer is valid.
+        unsafe { bindings::watchdog_hw_running(self.as_raw()) }
+    }
+}
+
+/// Flags describing the capabilities of a watchdog device, for use in
+/// [`super::Info::new`].
+pub mod flags {
+    /// The watchdog supports setting the timeout.
+    pub const SETTIMEOUT: u32 = bindings::WDIOF_SETTIMEOUT;
+    /// The watchdog supports keepalive pings.
+    pub const KEEPALIVEPING: u32 = bindings::WDIOF_KEEPALIVEPING;
+    /// The watchdog supports the magic close character.
+    pub const MAGICCLOSE: u32 = bindings::WDIOF_MAGICCLOSE;
+    /// The watchdog supports pretimeouts.
+    pub const PRETIMEOUT: u32 = bindings::WDIOF_PRETIMEOUT;
+}
+
+/// Watchdog identity information.
+///
+/// Wraps the kernel's [`struct watchdog_info`].
+///
+/// [`struct watchdog_info`]: srctree/include/uapi/linux/watchdog.h
+#[repr(transparent)]
+pub struct Info(bindings::watchdog_info);
+
+impl Info {
+    /// Creates a new [`Info`] with the given option [`flags`] and identity
+    /// string.
+    ///
+    /// The identity is truncated to 31 bytes to fit the fixed size,
+    /// NUL-terminated C field.
+    pub const fn new(options: u32, identity: &str) -> Self {
+        let mut id = [0u8; 32];
+        let bytes = identity.as_bytes();
+        let mut i = 0;
+        while i < bytes.len() && i < id.len() - 1 {
+            id[i] = bytes[i];
+            i += 1;
+        }
+        Self(bindings::watchdog_info {
+            options,
+            firmware_version: 0,
+            identity: id,
+        })
+    }
+}
+
+/// Configuration for registering a watchdog device.
+///
+/// All timeouts are in seconds; `max_hw_heartbeat_ms` is in milliseconds.
+///
+/// The watchdog core requires either a [`WatchdogOps::stop`] implementation
+/// or a non-zero `max_hw_heartbeat_ms`, otherwise registration fails with
+/// `EINVAL`.
+pub struct Options {
+    /// The default timeout in seconds.
+    pub timeout: u32,
+    /// The minimum settable timeout in seconds.
+    pub min_timeout: u32,
+    /// The maximum settable timeout in seconds.
+    pub max_timeout: u32,
+    /// Hardware limit for the maximum timeout, in milliseconds.
+    /// Zero means no hardware limit.
+    pub max_hw_heartbeat_ms: u32,
+    /// If `true`, the watchdog cannot be stopped once started.
+    pub nowayout: bool,
+    /// If `true`, the watchdog is stopped on system reboot. Requires a
+    /// [`WatchdogOps::stop`] implementation.
+    pub stop_on_reboot: bool,
+}
+
+impl Default for Options {
+    fn default() -> Self {
+        Self {
+            timeout: 0,
+            min_timeout: 0,
+            max_timeout: 0,
+            max_hw_heartbeat_ms: 0,
+            nowayout: cfg!(CONFIG_WATCHDOG_NOWAYOUT),
+            stop_on_reboot: false,
+        }
+    }
+}
+
+/// An adapter for the registration of a watchdog driver.
+struct Adapter<T: WatchdogOps> {
+    _p: PhantomData<T>,
+}
+
+impl<T: WatchdogOps> Adapter<T> {
+    /// Returns a reference to the driver data of a registered device.
+    ///
+    /// # Safety
+    ///
+    /// - `wdd` must be a `watchdog_device` registered via [`Registration`],
+    ///   so that its driver data points at a valid `T::Data`.
+    /// - The returned reference must not outlive the callback invocation.
+    unsafe fn data_from_raw<'a>(wdd: *mut bindings::watchdog_device) -> &'a T::Data {
+        // SAFETY: `Registration::register` stored a pointer to the heap
+        // allocated `T::Data` as driver data of this device, valid until
+        // unregistration tears down the paths that invoke callbacks.
+        unsafe { &*bindings::watchdog_get_drvdata(wdd).cast::<T::Data>() }
+    }
+
+    /// # Safety
+    ///
+    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
+    unsafe extern "C" fn start_callback(wdd: *mut bindings::watchdog_device) -> c_int {
+        from_result(|| {
+            // SAFETY: The pointer is valid for the duration of the callback.
+            let dev = unsafe { Device::from_raw(wdd) };
+            // SAFETY: `wdd` was registered by `Registration`.
+            let data = unsafe { Self::data_from_raw(wdd) };
+            T::start(dev, data)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
+    unsafe extern "C" fn stop_callback(wdd: *mut bindings::watchdog_device) -> c_int {
+        from_result(|| {
+            // SAFETY: The pointer is valid for the duration of the callback.
+            let dev = unsafe { Device::from_raw(wdd) };
+            // SAFETY: `wdd` was registered by `Registration`.
+            let data = unsafe { Self::data_from_raw(wdd) };
+            T::stop(dev, data)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
+    unsafe extern "C" fn ping_callback(wdd: *mut bindings::watchdog_device) -> c_int {
+        from_result(|| {
+            // SAFETY: The pointer is valid for the duration of the callback.
+            let dev = unsafe { Device::from_raw(wdd) };
+            // SAFETY: `wdd` was registered by `Registration`.
+            let data = unsafe { Self::data_from_raw(wdd) };
+            T::ping(dev, data)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
+    unsafe extern "C" fn set_timeout_callback(
+        wdd: *mut bindings::watchdog_device,
+        timeout: c_uint,
+    ) -> c_int {
+        from_result(|| {
+            // SAFETY: The pointer is valid for the duration of the callback.
+            let dev = unsafe { Device::from_raw(wdd) };
+            // SAFETY: `wdd` was registered by `Registration`.
+            let data = unsafe { Self::data_from_raw(wdd) };
+            T::set_timeout(dev, data, timeout)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
+    unsafe extern "C" fn set_pretimeout_callback(
+        wdd: *mut bindings::watchdog_device,
+        pretimeout: c_uint,
+    ) -> c_int {
+        from_result(|| {
+            // SAFETY: The pointer is valid for the duration of the callback.
+            let dev = unsafe { Device::from_raw(wdd) };
+            // SAFETY: `wdd` was registered by `Registration`.
+            let data = unsafe { Self::data_from_raw(wdd) };
+            T::set_pretimeout(dev, data, pretimeout)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
+    unsafe extern "C" fn get_timeleft_callback(wdd: *mut bindings::watchdog_device) -> c_uint {
+        // SAFETY: The pointer is valid for the duration of the callback.
+        let dev = unsafe { Device::from_raw(wdd) };
+        // SAFETY: `wdd` was registered by `Registration`.
+        let data = unsafe { Self::data_from_raw(wdd) };
+        T::get_timeleft(dev, data)
+    }
+}
+
+/// Watchdog device operations.
+///
+/// Implement this trait to provide the callbacks for a watchdog device.
+/// Only [`WatchdogOps::start`] is mandatory; all other operations are
+/// optional. Note that the watchdog core requires either a
+/// [`WatchdogOps::stop`] implementation or a non-zero
+/// [`Options::max_hw_heartbeat_ms`].
+///
+/// Every callback receives a reference to the driver's private data of type
+/// [`WatchdogOps::Data`], which is passed to [`Registration::register`] and
+/// freed when the [`Registration`] is dropped.
+///
+/// Callbacks may be invoked concurrently (the watchdog core does not hold
+/// its lock on every path), so the data must be [`Sync`] and any mutable
+/// driver state needs its own synchronisation.
+#[vtable]
+pub trait WatchdogOps {
+    /// Driver private data, accessible from all callbacks.
+    type Data: Send + Sync;
+
+    /// Starts the watchdog device.
+    ///
+    /// This is the only mandatory operation.
+    fn start(dev: &Device, data: &Self::Data) -> Result;
+
+    /// Stops the watchdog device.
+    fn stop(_dev: &Device, _data: &Self::Data) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Sends a keepalive ping to the watchdog device.
+    fn ping(_dev: &Device, _data: &Self::Data) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Sets the watchdog timeout in seconds.
+    fn set_timeout(_dev: &Device, _data: &Self::Data, _timeout: u32) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Sets the watchdog pretimeout in seconds.
+    fn set_pretimeout(_dev: &Device, _data: &Self::Data, _pretimeout: u32) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Returns the time left before the watchdog fires (in seconds).
+    fn get_timeleft(_dev: &Device, _data: &Self::Data) -> u32 {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Creates a [`bindings::watchdog_ops`] instance from [`WatchdogOps`].
+///
+/// The `owner` field is filled in by [`Registration::register`].
+const fn create_watchdog_ops<T: WatchdogOps>() -> bindings::watchdog_ops {
+    bindings::watchdog_ops {
+        owner: core::ptr::null_mut(),
+        start: Some(Adapter::<T>::start_callback),
+        stop: if T::HAS_STOP {
+            Some(Adapter::<T>::stop_callback)
+        } else {
+            None
+        },
+        ping: if T::HAS_PING {
+            Some(Adapter::<T>::ping_callback)
+        } else {
+            None
+        },
+        status: None,
+        set_timeout: if T::HAS_SET_TIMEOUT {
+            Some(Adapter::<T>::set_timeout_callback)
+        } else {
+            None
+        },
+        set_pretimeout: if T::HAS_SET_PRETIMEOUT {
+            Some(Adapter::<T>::set_pretimeout_callback)
+        } else {
+            None
+        },
+        get_timeleft: if T::HAS_GET_TIMELEFT {
+            Some(Adapter::<T>::get_timeleft_callback)
+        } else {
+            None
+        },
+        restart: None,
+        ioctl: None,
+    }
+}
+
+/// The heap allocated backing storage of a registration.
+///
+/// The watchdog core stores pointers into this structure (the device `ops`
+/// pointer points at `ops`, the device driver data points at `data`), so it
+/// is heap allocated and only reclaimed after unregistration.
+struct Inner<T: WatchdogOps> {
+    wdd: Opaque<bindings::watchdog_device>,
+    ops: bindings::watchdog_ops,
+    data: T::Data,
+}
+
+/// Watchdog device registration.
+///
+/// Registers a watchdog device with the kernel. The device is unregistered
+/// and the driver data dropped when this instance is dropped.
+///
+/// # Invariants
+///
+/// - `inner` points at a live [`Inner`] obtained from [`KBox::into_raw`],
+///   registered with the watchdog core via `watchdog_register_device`.
+/// - The registered device's `ops` pointer and driver data pointer point at
+///   the `ops` and `data` fields of that [`Inner`].
+pub struct Registration<T: WatchdogOps> {
+    inner: *mut Inner<T>,
+}
+
+// SAFETY: `bindings::watchdog_device` contains raw pointers managed
+// exclusively by the watchdog core, which is thread safe. `T::Data` is
+// `Send` per the trait bound, so the heap allocation may be dropped from
+// any thread.
+unsafe impl<T: WatchdogOps> Send for Registration<T> {}
+
+// SAFETY: `Registration` has no `&self` methods, so sharing references to
+// it across threads gives access to nothing.
+unsafe impl<T: WatchdogOps> Sync for Registration<T> {}
+
+impl<T: WatchdogOps> Registration<T> {
+    /// Creates and registers a new watchdog device.
+    ///
+    /// `module` is used to set the `owner` field of the watchdog operations,
+    /// ensuring correct module reference counting while `/dev/watchdog` is
+    /// open. `data` is the driver's private data, passed to every callback.
+    ///
+    /// The watchdog is configured to stop on unregistration. Note that the
+    /// core skips that stop under `nowayout`, and that for drivers without
+    /// a [`WatchdogOps::stop`] implementation an active hardware watchdog
+    /// keeps running after unregistration with nobody pinging it, which
+    /// leads to a system reset. In all cases the core tears down its
+    /// character device and keepalive worker before unregistration
+    /// returns, so no callback can run after the driver data has been
+    /// freed.
+    pub fn register(
+        module: &'static crate::ThisModule,
+        parent: Option<&device::Device>,
+        info: &'static Info,
+        options: &Options,
+        data: T::Data,
+    ) -> Result<Self> {
+        // The core silently ignores the stop-on-reboot notifier for devices
+        // without a stop operation; reject the combination instead.
+        if options.stop_on_reboot && !T::HAS_STOP {
+            return Err(EINVAL);
+        }
+
+        let mut ops = create_watchdog_ops::<T>();
+        ops.owner = module.as_ptr();
+
+        let wdd = bindings::watchdog_device {
+            // CAST: `Info` is a `repr(transparent)` wrapper around
+            // `bindings::watchdog_info`.
+            info: core::ptr::from_ref(info).cast(),
+            timeout: options.timeout,
+            min_timeout: options.min_timeout,
+            max_timeout: options.max_timeout,
+            max_hw_heartbeat_ms: options.max_hw_heartbeat_ms,
+            parent: parent.map_or(core::ptr::null_mut(), |p| p.as_raw()),
+            ..pin_init::zeroed()
+        };
+
+        let inner = KBox::new(
+            Inner {
+                wdd: Opaque::new(wdd),
+                ops,
+                data,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // Transfer the allocation to a raw pointer so that no reference to
+        // `Inner` exists while the C core holds pointers into it. It is
+        // reclaimed with `KBox::from_raw` in `Drop` (or below on failure).
+        let inner = KBox::into_raw(inner);
+
+        // The pointers below are derived from `inner` and point into the
+        // heap allocation, so they remain valid until the allocation is
+        // reclaimed.
+
+        // SAFETY: `inner` came from `KBox::into_raw`, so it points at a live
+        // allocation and the field projection stays in bounds.
+        let wdd_ptr = Opaque::cast_into(unsafe { &raw const (*inner).wdd });
+        // SAFETY: As above.
+        let ops_ptr: *const bindings::watchdog_ops = unsafe { &raw const (*inner).ops };
+        // SAFETY: As above.
+        let data_ptr: *const T::Data = unsafe { &raw const (*inner).data };
+
+        // SAFETY: `wdd_ptr` points at a valid `watchdog_device` that is not
+        // yet registered, so we have exclusive access.
+        unsafe {
+            (*wdd_ptr).ops = ops_ptr;
+            bindings::watchdog_set_drvdata(wdd_ptr, data_ptr.cast_mut().cast());
+            bindings::watchdog_set_nowayout(wdd_ptr, options.nowayout);
+            // Stop the watchdog on unregistration so that no callback can
+            // run after `Inner` has been freed.
+            bindings::watchdog_stop_on_unregister(wdd_ptr);
+            if options.stop_on_reboot {
+                bindings::watchdog_stop_on_reboot(wdd_ptr);
+            }
+        }
+
+        // SAFETY: `wdd_ptr` points at a fully initialised `watchdog_device`.
+        let ret = unsafe { bindings::watchdog_register_device(wdd_ptr) };
+        if ret != 0 {
+            // SAFETY: `inner` came from `KBox::into_raw` above and was not
+            // registered, so we have exclusive ownership of it.
+            drop(unsafe { KBox::from_raw(inner) });
+            return Err(Error::from_errno(ret));
+        }
+
+        // INVARIANT: `inner` is registered and its `ops`/`data` fields are
+        // referenced by the registered device.
+        Ok(Registration { inner })
+    }
+}
+
+impl<T: WatchdogOps> Drop for Registration<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariant guarantees that `self.inner` is live
+        // and registered. Unregistration tears down the character device
+        // and the core's keepalive worker before returning, so no callback
+        // can run afterwards.
+        unsafe {
+            bindings::watchdog_unregister_device(Opaque::cast_into(&raw const (*self.inner).wdd))
+        };
+        // SAFETY: `self.inner` came from `KBox::into_raw` and the device is
+        // now unregistered, so we have exclusive ownership of the
+        // allocation and can reclaim and drop it.
+        drop(unsafe { KBox::from_raw(self.inner) });
+    }
+}

base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
-- 
2.43.0

