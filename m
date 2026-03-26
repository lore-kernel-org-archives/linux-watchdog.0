Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2DF23AB98
	for <linux-watchdog@vger.kernel.org>; Thu, 26 Mar 2026 05:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774501384; cv=none; b=JQX637WEKgf8dWLhk03x3Py/mZ1YE/dnh6gVjNK5QIbpfZ1Knm/FxVJaTCpJWICs8mDpJI1UwIYrZA660xtGOx+Q1mRjSsbVEH7iicTJ3m+6pqc7WEvfdAlWMuEBLtl4gE3scsuiFKXLj9ubsf1PFWPSIv/o3GLHXEGyuLj8RZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774501384; c=relaxed/simple;
	bh=G4TOG+U8adx2T4YVuoutSMkmvPV4/b4Z8moqTbL1AE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5qJC7h+X2CYZrVKdEDeFas1Z9Nub2gCXdix1qQNiJGPv02SCZFl0xyYDsJTOQwaiKqt8dwEA0u+fwsRpgapUXWe3Nq1ja5JUJNU9UQHml2UXVayd40qbYWH7oMnly0xqBh5Io7cacusqYqOXN5JNx01fgCwEe6+6n3lbJVUSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8T+dgn5; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8T+dgn5"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12a695044a4so1279220c88.0
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Mar 2026 22:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774501381; x=1775106181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I87eQEwE1u2yh1e5TEre+WpX16f/WRrEh2+13qHlKqw=;
        b=K8T+dgn5I7XcQWwXt4ATikyx+afVo4sHWdDYZ29TyIrb8xv9O+ewIHlSJ87Tou7Bn+
         EElnWo8fl3DO0qukpSD7+mHiNtKIv5U5k8VdBtnEqH6tv+XD1hBy/1apGd/5wXM6COl+
         3yA6Y0L9M71N0cgHH2hK+qISwNZ7hlztuRmkZcv/IX9X/BM05c8S1hOTFb6eDrTdZeAP
         f6gfGGV3SsckcJfqZaV1VfLpSLZVztQbzeubdpS9k0Xnyt+CRdNm/efmXRT8+j77IGbj
         UdXtc0AOEXu3/ZHLdVLwOVVUf3bpgx2SLpGCGIJm9OrrV9f7tS78NaoV8ROnGCZB0M8l
         ftUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774501381; x=1775106181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I87eQEwE1u2yh1e5TEre+WpX16f/WRrEh2+13qHlKqw=;
        b=rPadyWFEBS+xdjwc4JHXuxlqgegCxstV4N37pbHW00GbeiCiQ72W0LZr+pFL2bRukg
         m86+ZJA0Y/V+IANEZfAZ2DvB9R3Grc3iktlUeGvKIKcJPAlWGhJooxEn5y3wScBHPo+F
         cnWZv/81KrthSofBBGaKGVtFUmHIqqAs2P+tGiCFSO1EH5rsHnKVFMxNPAPsNOAfsXRU
         4QmexPiRVLm9POIUldFex7yV1nkiPhyyrm25x7ZGzGNWHcH2lzX37qFwrjZ6oqS2rUn0
         QuLWVIlxMfBze6r67WCj1h6DoNniqVorfBrUFP6eBotJSGfpunfxZUztxaq1GX4BlqWz
         ESxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrLVTGozelHfBK8kYhTWlMyljNqntWfLLga7nb/pb64HsEg3T0w595rDmeeL8nPUBkOb4kiM6JrbYf9QtfDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx96l8w3Jygqcrh9MsjzDypMygBZKVcNRUwOUFHyDbFdcnanHDl
	QIw4ub05qQtcmAn/zKl7POKCJQtG43vrvsA+JZ8k6SEeh9G/UYj+IJ7u
X-Gm-Gg: ATEYQzzjB6wn5IQWIo/rXYWViv/xi+x5tn/DJKZY4ydkuyJOwdiQaJrT92TI1EI6hSR
	YOQ7ZYq1LlWoQIu+QWGm17iUFDLYr6CwdSIGtftSIwqJ/HeRo7I6FG8cqiIi6wKSe/jkgZ0LLcA
	hoaA5dH+cIKWUjlhEty9Cs2ZHe7Gi4IF+vrMlb2KPkUGGtG3eUZpUkCx0yyr9vyTz4yAOjAnWRw
	Y7UipBmpx1OVtsTjcMDfTsl70wi3tfZcfuSUbKg5Bgib5GdftF7ufRWAZ3i5pCTukZVl5frUcJr
	/PvBTXf/i1tuxxcTtMGo0l1H/owD47KiN7Y43fPKKfE7HjKSRx3CUAdIfARZn0s2jPBELGxHggW
	a7jACsEVVi9oxQZZ4hsyFA3rKKyTzMdrV6ESWgHlEj10ADunT/CC64cZ92ILnMf1oKsyS6FWi3p
	nM22JYm1SmZEigh9zHtE5/qP9PYCNJvSlMWRC+pKADLR4rp+aB7kLhaYJ4NvfKfoZhclUtO7UXa
	IqTxqyBZZ4=
X-Received: by 2002:a05:7022:327:b0:128:d0df:a66b with SMTP id a92af1059eb24-12a96ed75ddmr3001302c88.26.1774501380603;
        Wed, 25 Mar 2026 22:03:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa7274231sm2206794c88.8.2026.03.25.22.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 22:03:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e1fce833-d813-4967-8260-334afc36a1dc@roeck-us.net>
Date: Wed, 25 Mar 2026 22:02:58 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: watchdog: add watchdog device abstraction
To: Artem Lytkin <iprintercanon@gmail.com>, linux-watchdog@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: wim@linux-watchdog.org, ojeda@kernel.org, dakr@kernel.org,
 aliceryhl@google.com, a.hindborg@kernel.org, lossin@kernel.org
References: <20260323195138.5541-1-iprintercanon@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260323195138.5541-1-iprintercanon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 12:51, Artem Lytkin wrote:
> Add Rust abstractions for the Linux watchdog subsystem, enabling
> watchdog drivers to be written in Rust.
> 
> The abstraction follows the pattern established by the PHY driver
> abstraction (rust/kernel/net/phy.rs):
> 
>    - A `Device` wrapper around `struct watchdog_device` providing safe
>      accessors for timeout, pretimeout, and status fields.
> 
>    - A `#[vtable] WatchdogOps` trait where `start()` is mandatory and
>      `stop()`, `ping()`, `set_timeout()`, `set_pretimeout()`, and
>      `get_timeleft()` are optional.
> 
>    - An `Adapter` struct with `unsafe extern "C" fn` callbacks that
>      bridge the C watchdog core to Rust trait methods.
> 
>    - A `create_watchdog_ops()` const function that populates the C
>      `watchdog_ops` struct at compile time.
> 
>    - A `Registration` type that heap-allocates the `watchdog_device`
>      via `KBox` to ensure pointer stability (the C core stores
>      back-pointers into the device struct), and wraps
>      `watchdog_register_device` / `watchdog_unregister_device` with
>      RAII semantics.
> 
> The `Registration::register` method takes a `&'static ThisModule`
> parameter to set the `owner` field in `watchdog_ops`, ensuring
> correct module reference counting when userspace opens /dev/watchdog.
> 
> Also add C helper functions for inline watchdog functions that bindgen
> cannot handle and include `linux/watchdog.h` in the bindings header.
> 
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>

My knowledge and understanding of rust is pretty much zero, so I won't
provide any feedback on this patch.

However, you might want to have a look at the Sashiko feedback and
either address the concerns or add comments explaining why they
are irrelevant and how the driver works even with the limitations
outlined by the AI agent.

https://sashiko.dev/#/patchset/20260323195138.5541-1-iprintercanon%40gmail.com

Thanks,
Guenter

> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/helpers/helpers.c          |   1 +
>   rust/helpers/watchdog.c         |  38 ++++
>   rust/kernel/lib.rs              |   2 +
>   rust/kernel/watchdog.rs         | 348 ++++++++++++++++++++++++++++++++
>   5 files changed, 390 insertions(+)
>   create mode 100644 rust/helpers/watchdog.c
>   create mode 100644 rust/kernel/watchdog.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index a067038b4b422..df53d03846808 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -84,6 +84,7 @@
>   #include <linux/tracepoint.h>
>   #include <linux/usb.h>
>   #include <linux/wait.h>
> +#include <linux/watchdog.h>
>   #include <linux/workqueue.h>
>   #include <linux/xarray.h>
>   #include <trace/events/rust_sample.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 79c72762ad9c4..e53e9977fd3e7 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -60,5 +60,6 @@
>   #include "usb.c"
>   #include "vmalloc.c"
>   #include "wait.c"
> +#include "watchdog.c"
>   #include "workqueue.c"
>   #include "xarray.c"
> diff --git a/rust/helpers/watchdog.c b/rust/helpers/watchdog.c
> new file mode 100644
> index 0000000000000..175cebbeb1b36
> --- /dev/null
> +++ b/rust/helpers/watchdog.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/watchdog.h>
> +
> +bool rust_helper_watchdog_active(struct watchdog_device *wdd)
> +{
> +	return watchdog_active(wdd);
> +}
> +
> +bool rust_helper_watchdog_hw_running(struct watchdog_device *wdd)
> +{
> +	return watchdog_hw_running(wdd);
> +}
> +
> +void rust_helper_watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
> +{
> +	watchdog_set_nowayout(wdd, nowayout);
> +}
> +
> +void rust_helper_watchdog_stop_on_reboot(struct watchdog_device *wdd)
> +{
> +	watchdog_stop_on_reboot(wdd);
> +}
> +
> +void rust_helper_watchdog_stop_on_unregister(struct watchdog_device *wdd)
> +{
> +	watchdog_stop_on_unregister(wdd);
> +}
> +
> +void rust_helper_watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
> +{
> +	watchdog_set_drvdata(wdd, data);
> +}
> +
> +void *rust_helper_watchdog_get_drvdata(struct watchdog_device *wdd)
> +{
> +	return watchdog_get_drvdata(wdd);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f812cf1200428..e65b8bd721978 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -149,6 +149,8 @@
>   pub mod transmute;
>   pub mod types;
>   pub mod uaccess;
> +#[cfg(CONFIG_WATCHDOG)]
> +pub mod watchdog;
>   #[cfg(CONFIG_USB = "y")]
>   pub mod usb;
>   pub mod workqueue;
> diff --git a/rust/kernel/watchdog.rs b/rust/kernel/watchdog.rs
> new file mode 100644
> index 0000000000000..e65438f004109
> --- /dev/null
> +++ b/rust/kernel/watchdog.rs
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Watchdog device support.
> +//!
> +//! C headers: [`include/linux/watchdog.h`](srctree/include/linux/watchdog.h).
> +
> +use crate::{bindings, device, error::*, prelude::*, types::Opaque};
> +use core::marker::PhantomData;
> +
> +/// A watchdog device.
> +///
> +/// Wraps the kernel's [`struct watchdog_device`].
> +///
> +/// # Invariants
> +///
> +/// The pointer is valid and the watchdog core serialises access to the device
> +/// during callback execution.
> +///
> +/// [`struct watchdog_device`]: srctree/include/linux/watchdog.h
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::watchdog_device>);
> +
> +impl Device {
> +    /// Creates a new [`Device`] reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `ptr` must point at a valid `watchdog_device`.
> +    /// - The caller must be in a callback context where the watchdog core
> +    ///   serialises access.
> +    /// - The returned reference must not outlive the callback invocation.
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::watchdog_device) -> &'a mut Self {
> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::watchdog_device`.
> +        let ptr = ptr.cast::<Self>();
> +        // SAFETY: By the function requirements the pointer is valid and we have
> +        // exclusive access for the duration of the callback.
> +        unsafe { &mut *ptr }
> +    }
> +
> +    /// Returns a raw pointer to the underlying `watchdog_device`.
> +    fn as_raw(&self) -> *mut bindings::watchdog_device {
> +        self.0.get()
> +    }
> +
> +    /// Returns the current timeout in seconds.
> +    pub fn timeout(&self) -> u32 {
> +        // SAFETY: The struct invariant ensures we may access this field.
> +        unsafe { (*self.as_raw()).timeout }
> +    }
> +
> +    /// Sets the current timeout in seconds.
> +    pub fn set_timeout(&mut self, timeout: u32) {
> +        // SAFETY: The struct invariant ensures exclusive access.
> +        unsafe { (*self.as_raw()).timeout = timeout };
> +    }
> +
> +    /// Returns the current pretimeout in seconds.
> +    pub fn pretimeout(&self) -> u32 {
> +        // SAFETY: The struct invariant ensures we may access this field.
> +        unsafe { (*self.as_raw()).pretimeout }
> +    }
> +
> +    /// Returns the minimum timeout in seconds.
> +    pub fn min_timeout(&self) -> u32 {
> +        // SAFETY: The struct invariant ensures we may access this field.
> +        unsafe { (*self.as_raw()).min_timeout }
> +    }
> +
> +    /// Returns the maximum timeout in seconds.
> +    pub fn max_timeout(&self) -> u32 {
> +        // SAFETY: The struct invariant ensures we may access this field.
> +        unsafe { (*self.as_raw()).max_timeout }
> +    }
> +
> +    /// Returns `true` if the watchdog is active.
> +    pub fn is_active(&self) -> bool {
> +        // SAFETY: The struct invariant ensures the pointer is valid.
> +        unsafe { bindings::watchdog_active(self.as_raw()) }
> +    }
> +
> +    /// Returns `true` if the hardware watchdog is running.
> +    pub fn is_hw_running(&self) -> bool {
> +        // SAFETY: The struct invariant ensures the pointer is valid.
> +        unsafe { bindings::watchdog_hw_running(self.as_raw()) }
> +    }
> +}
> +
> +/// An adapter for the registration of a watchdog driver.
> +struct Adapter<T: WatchdogOps> {
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: WatchdogOps> Adapter<T> {
> +    /// # Safety
> +    ///
> +    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
> +    unsafe extern "C" fn start_callback(
> +        wdd: *mut bindings::watchdog_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The watchdog core serialises access to the device.
> +            let dev = unsafe { Device::from_raw(wdd) };
> +            T::start(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
> +    unsafe extern "C" fn stop_callback(
> +        wdd: *mut bindings::watchdog_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The watchdog core serialises access to the device.
> +            let dev = unsafe { Device::from_raw(wdd) };
> +            T::stop(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
> +    unsafe extern "C" fn ping_callback(
> +        wdd: *mut bindings::watchdog_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The watchdog core serialises access to the device.
> +            let dev = unsafe { Device::from_raw(wdd) };
> +            T::ping(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
> +    unsafe extern "C" fn set_timeout_callback(
> +        wdd: *mut bindings::watchdog_device,
> +        timeout: core::ffi::c_uint,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The watchdog core serialises access to the device.
> +            let dev = unsafe { Device::from_raw(wdd) };
> +            T::set_timeout(dev, timeout)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
> +    unsafe extern "C" fn set_pretimeout_callback(
> +        wdd: *mut bindings::watchdog_device,
> +        pretimeout: core::ffi::c_uint,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The watchdog core serialises access to the device.
> +            let dev = unsafe { Device::from_raw(wdd) };
> +            T::set_pretimeout(dev, pretimeout)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `wdd` must be passed by the corresponding callback in `watchdog_ops`.
> +    unsafe extern "C" fn get_timeleft_callback(
> +        wdd: *mut bindings::watchdog_device,
> +    ) -> core::ffi::c_uint {
> +        // SAFETY: The watchdog core serialises access to the device.
> +        // We create a shared reference since get_timeleft only needs &Device.
> +        let dev = unsafe { &*(wdd.cast::<Device>()) };
> +        T::get_timeleft(dev)
> +    }
> +}
> +
> +/// Watchdog device operations.
> +///
> +/// Implement this trait to provide the callbacks for a watchdog device.
> +/// Only [`WatchdogOps::start`] is mandatory; all other operations are optional.
> +#[vtable]
> +pub trait WatchdogOps {
> +    /// Starts the watchdog device.
> +    ///
> +    /// This is the only mandatory operation.
> +    fn start(dev: &mut Device) -> Result;
> +
> +    /// Stops the watchdog device.
> +    fn stop(_dev: &mut Device) -> Result {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Sends a keepalive ping to the watchdog device.
> +    fn ping(_dev: &mut Device) -> Result {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Sets the watchdog timeout in seconds.
> +    fn set_timeout(_dev: &mut Device, _timeout: u32) -> Result {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Sets the watchdog pretimeout in seconds.
> +    fn set_pretimeout(_dev: &mut Device, _pretimeout: u32) -> Result {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Returns the time left before the watchdog fires (in seconds).
> +    fn get_timeleft(_dev: &Device) -> u32 {
> +        0
> +    }
> +}
> +
> +/// Creates a [`bindings::watchdog_ops`] instance from [`WatchdogOps`].
> +///
> +/// This populates the C ops struct at compile time based on which trait
> +/// methods are implemented. The `owner` field must be set separately by
> +/// the caller before registration.
> +pub const fn create_watchdog_ops<T: WatchdogOps>() -> bindings::watchdog_ops {
> +    bindings::watchdog_ops {
> +        owner: core::ptr::null_mut(),
> +        start: Some(Adapter::<T>::start_callback),
> +        stop: if T::HAS_STOP {
> +            Some(Adapter::<T>::stop_callback)
> +        } else {
> +            None
> +        },
> +        ping: if T::HAS_PING {
> +            Some(Adapter::<T>::ping_callback)
> +        } else {
> +            None
> +        },
> +        status: None,
> +        set_timeout: if T::HAS_SET_TIMEOUT {
> +            Some(Adapter::<T>::set_timeout_callback)
> +        } else {
> +            None
> +        },
> +        set_pretimeout: if T::HAS_SET_PRETIMEOUT {
> +            Some(Adapter::<T>::set_pretimeout_callback)
> +        } else {
> +            None
> +        },
> +        get_timeleft: if T::HAS_GET_TIMELEFT {
> +            Some(Adapter::<T>::get_timeleft_callback)
> +        } else {
> +            None
> +        },
> +        restart: None,
> +        ioctl: None,
> +    }
> +}
> +
> +/// Watchdog device registration.
> +///
> +/// Registers a watchdog device with the kernel. The device will be
> +/// unregistered when this instance is dropped.
> +///
> +/// The [`watchdog_device`] is heap-allocated to ensure a stable address,
> +/// since the watchdog core stores pointers back into it.
> +///
> +/// # Invariants
> +///
> +/// `inner` points to a heap-allocated `watchdog_device` that is registered
> +/// with the watchdog core via `watchdog_register_device`.
> +///
> +/// [`watchdog_device`]: srctree/include/linux/watchdog.h
> +pub struct Registration {
> +    inner: KBox<Opaque<bindings::watchdog_device>>,
> +}
> +
> +// SAFETY: `watchdog_unregister_device` can be called from any context.
> +// The `KBox` ensures the `watchdog_device` has a stable heap address that
> +// remains valid regardless of where the `Registration` is moved.
> +unsafe impl Send for Registration {}
> +
> +// SAFETY: The only method that returns a reference to the device (`device()`)
> +// returns `&Device` (shared reference), which only exposes read-only accessors.
> +// The watchdog core serialises access during callbacks.
> +unsafe impl Sync for Registration {}
> +
> +impl Registration {
> +    /// Creates and registers a new watchdog device.
> +    ///
> +    /// The `module` parameter is used to set the `owner` field in the
> +    /// watchdog ops, ensuring correct module reference counting when
> +    /// userspace opens `/dev/watchdog`.
> +    pub fn register(
> +        module: &'static crate::ThisModule,
> +        parent: Option<&device::Device>,
> +        info: &'static bindings::watchdog_info,
> +        ops: &'static mut bindings::watchdog_ops,
> +        timeout: u32,
> +        min_timeout: u32,
> +        max_timeout: u32,
> +        nowayout: bool,
> +    ) -> Result<Self> {
> +        // Set the module owner so the kernel holds a reference to our
> +        // module while /dev/watchdog is open.
> +        ops.owner = module.as_ptr();
> +
> +        let mut wdd: bindings::watchdog_device =
> +            // SAFETY: Zeroing out `watchdog_device` is valid since all fields
> +            // are simple types (integers, pointers) that can be zero-initialised.
> +            unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
> +
> +        wdd.info = info;
> +        wdd.ops = ops;
> +        wdd.timeout = timeout;
> +        wdd.min_timeout = min_timeout;
> +        wdd.max_timeout = max_timeout;
> +        wdd.parent = if let Some(p) = parent {
> +            p.as_raw()
> +        } else {
> +            core::ptr::null_mut()
> +        };
> +
> +        // SAFETY: The watchdog_device is fully initialised.
> +        unsafe { bindings::watchdog_set_nowayout(&mut wdd, nowayout) };
> +        // SAFETY: The watchdog_device is fully initialised.
> +        unsafe { bindings::watchdog_stop_on_reboot(&mut wdd) };
> +
> +        // Heap-allocate the watchdog_device so that the C core's back-pointers
> +        // remain valid even if this Registration is moved.
> +        let inner = KBox::new(Opaque::new(wdd), GFP_KERNEL)?;
> +
> +        // SAFETY: `inner` points to a properly initialised watchdog_device on
> +        // the heap. The pointer will remain stable for the lifetime of the KBox.
> +        to_result(unsafe { bindings::watchdog_register_device(inner.get()) })?;
> +
> +        Ok(Registration { inner })
> +    }
> +
> +    /// Returns a reference to the underlying [`Device`].
> +    pub fn device(&self) -> &Device {
> +        // SAFETY: `inner` points to a valid `watchdog_device`.
> +        unsafe { &*(self.inner.get() as *const Device) }
> +    }
> +}
> +
> +impl Drop for Registration {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariant guarantees that `self.inner` is registered.
> +        unsafe { bindings::watchdog_unregister_device(self.inner.get()) };
> +    }
> +}

