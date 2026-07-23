Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC63242DF
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824266; cv=none; b=e6uFdldKe6JZ1hJWQ0YiDGHMR96jSNrYahx7mr6YFQEkmvfLF3f6LHP72IhVHy17m0U5fS5rMqrMwhMKA7SNXyKlPl+jJUdHiZAntn39QCO7lUsSSjEz7+879GcuG3wGoX90uQKD2YogRytKG3bpIdCp26pHCjv7cBJH1kHDrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824266; c=relaxed/simple;
	bh=npq/wxwWnHm+W1J02kKqjzn98ZW9NcreyNbeWlwasFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HS6cbGufco9/9ASk3B3MR4spwt69GKxa0lj3qeIDKHE87+3oPbeF15Denp5m1hJvTvc0G9pGjM5v0sDtSrvDR8z7Lle39ZZvgqhTyjAV+64tU30ZvrjY4TbPkYZa7n1XQCi7LnXd8X85Pn3EoYmLCxgsyIfrwrOzi9muYdN+yQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22B81F000E9;
	Thu, 23 Jul 2026 16:31:04 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] rust: watchdog: add watchdog device abstraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Lytkin" <iprintercanon@gmail.com>
Cc: linux-watchdog@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260723161529.23759-2-iprintercanon@gmail.com>
References: <20260723161529.23759-1-iprintercanon@gmail.com>
 <20260723161529.23759-2-iprintercanon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 16:30:48 +0000
Message-Id: <20260723163104.F22B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Safe `Device::set_timeout` and `Device::timeout` cause data races =
(Undefined Behavior).
- [High] Missing `set_pretimeout` method in `Device`.
- [High] Missing commonly required driver fields (`bootstatus` and `min_hw_=
heartbeat_ms`) in `Options`.
- [Low] Missing `#[inline]` annotations on small abstraction methods.
- [Low] Imports do not follow the kernel vertical import style.
--

--- Patch [1]: [PATCH v2 1/3] rust: watchdog: add watchdog device abstracti=
on ---
commit a2fbd8297d0a9de19e082cbcf7ecd7a0e4b836b1
Author: Artem Lytkin <iprintercanon@gmail.com>
Subject: rust: watchdog: add watchdog device abstraction

This commit adds Rust abstractions for the Linux watchdog subsystem, enabli=
ng
watchdog drivers to be written in Rust. It introduces wrappers for the
watchdog device, identity info, and options, along with a trait for driver
operations and a registration mechanism.

> diff --git a/rust/kernel/watchdog.rs b/rust/kernel/watchdog.rs
> new file mode 100644
> index 0000000000000..155eecc679238
> --- /dev/null
> +++ b/rust/kernel/watchdog.rs
> @@ -0,0 +1,522 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Watchdog device support.
> +//!
> +//! C headers: [`include/linux/watchdog.h`](srctree/include/linux/watchd=
og.h).
> +
> +use crate::{bindings, device, error::*, prelude::*, types::Opaque};

[Severity: Low]
This isn't a bug, but should the imports here follow the kernel vertical
import style as documented in the general coding guidelines?

> +use core::marker::PhantomData;
> +

[ ... ]

> +impl Device {
> +    /// Creates a new [`Device`] reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `ptr` must point at a valid `watchdog_device`.
> +    /// - The returned reference must not outlive the callback invocatio=
n.
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::watchdog_device) -> &'a S=
elf {

[Severity: Low]
This isn't a bug, but should small or forwarding functions in abstractions,
such as from_raw(), as_raw(), and the various getter/setter methods below,
be annotated with #[inline] according to the Rust subsystem guidelines?

> +        // CAST: `Self` is a `repr(transparent)` wrapper around
> +        // `bindings::watchdog_device`.
> +        let ptr =3D ptr.cast::<Self>();
> +        // SAFETY: By the function requirements the pointer is valid.
> +        unsafe { &*ptr }
> +    }
> +
> +    /// Returns a raw pointer to the underlying `watchdog_device`.
> +    fn as_raw(&self) -> *mut bindings::watchdog_device {
> +        self.0.get()
> +    }
> +
> +    /// Returns the current timeout in seconds.
> +    pub fn timeout(&self) -> u32 {
> +        // SAFETY: The struct invariant ensures the pointer is valid. The
> +        // read of this `unsigned int` field mirrors how the C core and C
> +        // drivers access it without synchronisation.
> +        unsafe { (*self.as_raw()).timeout }
> +    }
> +
> +    /// Sets the current timeout in seconds.
> +    pub fn set_timeout(&self, timeout: u32) {
> +        // SAFETY: The struct invariant ensures the pointer is valid. The
> +        // field lives in an `Opaque`, so writing through a shared refer=
ence
> +        // is allowed; the C core accesses this field the same way.
> +        unsafe { (*self.as_raw()).timeout =3D timeout };
> +    }

[Severity: High]
Since the commit message notes that callbacks can run concurrently without
holding a lock, does exposing these safe read and write methods cause a data
race when accessed from multiple threads?

In Rust, unsynchronized concurrent access where at least one is a write
constitutes undefined behavior. Should these methods use volatile or atomic
accesses to mirror READ_ONCE/WRITE_ONCE, or require caller synchronization?

> +
> +    /// Returns the current pretimeout in seconds.
> +    pub fn pretimeout(&self) -> u32 {
> +        // SAFETY: See `timeout`.
> +        unsafe { (*self.as_raw()).pretimeout }
> +    }

[Severity: High]
If a driver provides a set_pretimeout callback, the C watchdog core expects
the driver to update the internal wdd->pretimeout field upon success.

Since the Device abstraction only provides a getter for pretimeout, how can=
 a
Rust driver correctly update this core state without a set_pretimeout() met=
hod?

> +
> +    /// Returns the minimum timeout in seconds.
> +    pub fn min_timeout(&self) -> u32 {

[ ... ]

> +pub struct Options {
> +    /// The default timeout in seconds.
> +    pub timeout: u32,
> +    /// The minimum settable timeout in seconds.
> +    pub min_timeout: u32,
> +    /// The maximum settable timeout in seconds.
> +    pub max_timeout: u32,
> +    /// Hardware limit for the maximum timeout, in milliseconds.
> +    /// Zero means no hardware limit.
> +    pub max_hw_heartbeat_ms: u32,
> +    /// If `true`, the watchdog cannot be stopped once started.
> +    pub nowayout: bool,
> +    /// If `true`, the watchdog is stopped on system reboot. Requires a
> +    /// [`WatchdogOps::stop`] implementation.
> +    pub stop_on_reboot: bool,
> +}

[Severity: High]
Are commonly required driver fields like bootstatus and min_hw_heartbeat_ms
missing from this Options struct?

Because missing fields are zero-initialized in Registration::register() and
there are no setters in Device, are drivers unable to configure these stand=
ard
features, such as reporting WDIOF_CARDRESET?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723161529.2375=
9-1-iprintercanon@gmail.com?part=3D1
