Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7B136358
	for <linux-watchdog@vger.kernel.org>; Wed,  1 Jul 2026 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873986; cv=none; b=i2GmtKTXbDG1vWyFiVznWyMnIUyX6mJGZhupp3fSA1E1o8VNv8cXWy0m0/p3gMB/vcg6H5vTYvO5RfakUYsx+4TwzzoaWiMVuDYHmwRxgdzlsPtYhvBYQIOSvdL6RlemzTuGdRH4PVPq08okiBMgvg53jGDDR7g/oSsUaUY54Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873986; c=relaxed/simple;
	bh=dG967m8KumLH2JB1EIgPq8herja/Lwu4nR7yqSk5vZw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HzCss2g/pF3sMGF4gJE3ler7NGOelq7Q3XwUfLVjQ3jWJECeC9Xp4C1/GGsB/BN987nXbpg2n8HTmHOXZq5/gGEfuBAIMXJuG2jzdObWT/y/OHly6rUKwDOtgOA8oL+C0JkKl4fU/jJ5dl7uM41w8pOfNeX17DGJZxFDd+48riI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nlFkCroE; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nlFkCroE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1782873965; x=1783133165;
	bh=dG967m8KumLH2JB1EIgPq8herja/Lwu4nR7yqSk5vZw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nlFkCroE7yJnYaESzOOMfkL7TVPtkWy+b//X8HbGnU6pDjPyinI2ZWzlwr4LWtl1I
	 NBvjOw6f04Nv8n9fJXsvMYYIU5psJxDpCZNuWwqMpp/Y68ZHpbITQRjKUpBzf60XhD
	 gQwvDuQG3o2AUXdwDIRSaz4xzLXLpHquCcldJAxnAdMqTBNp/Lp/AjiKybdcfJlcyY
	 FLnP0QGPtIGTaz3+c3pNuIdmfwUzBZAVQiKSVIvYLDb0LJQPHgSvQ+h0Qyt6Pxk3oS
	 cEDVsDtF8oS1tsaYB7y8ychDncFjW2kWi2EEklWcmgXsCG9Jk8GVyfbnDGE+0NtCEO
	 tOc4oXjfFbwjw==
Date: Wed, 01 Jul 2026 02:46:02 +0000
To: "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>
From: Evict7837 <Evict7837@proton.me>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: iTCO_wdt: watchdog pretimeout panic after KVM guest suspend/resume
Message-ID: <odOoKUew64I3M0Rw7X5VzzgGB3eAx_dZ355qK2bC6cH7tfmBGLGLaq8C1idS0FO6e0iy-yyZhT91T1qisUuZfw9Ho8fa0nSiY4QBRh3oosk=@proton.me>
Feedback-ID: 67194071:user:proton
X-Pm-Message-ID: 87e1e8fe2430fbfb8430b9e26c20d8d8baa5ff02
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------cb3d5b28620ffa16497a0d5f42169376b33ecc31660d0ee91ea93263387ff6b5"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------cb3d5b28620ffa16497a0d5f42169376b33ecc31660d0ee91ea93263387ff6b5
Content-Type: multipart/mixed;boundary=---------------------c380fa9476170469f27749931ade3dee

-----------------------c380fa9476170469f27749931ade3dee
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

`Hi,`

`I'd like to report a kernel panic in iTCO_wdt triggered reproducibly afte=
r`
`suspending and resuming a KVM virtual machine host.`

`=3D=3D Environment =3D=3D`

`Host:`
=C2=A0 `OS: =C2=A0 =C2=A0 =C2=A0Ubuntu 24.04.4 LTS`
=C2=A0 `Kernel: =C2=A06.17.0-35-generic`
=C2=A0 `CPU: =C2=A0 =C2=A0 AMD Ryzen 7 6800H`
=C2=A0 `QEMU: =C2=A0 =C2=A08.2.2 (Debian 1:8.2.2+ds-0ubuntu1.17)`
=C2=A0 `libvirt: 10.0.0`

`Guest:`
=C2=A0 `OS: =C2=A0 =C2=A0 =C2=A0Rocky Linux 10.2`
=C2=A0 `Kernel: =C2=A06.12.0-211.26.1.el10_2.x86_64`
=C2=A0 `vCPU: =C2=A0 =C2=A01`
=C2=A0 `RAM: =C2=A0 =C2=A0 1 GiB`
=C2=A0 `Machine: Q35 + ICH9`
=C2=A0 `Watchdog device exposed via libvirt XML:`
=C2=A0 =C2=A0 `<watchdog model=3D"itco" action=3D"reset"/>`
=C2=A0 `Modules loaded: iTCO_wdt, iTCO_vendor_support`

`=3D=3D Bug Description =3D=3D`

`After suspending the KVM host for >=3D 1 minute and resuming, the guest`
`kernel panics with "watchdog pretimeout event". The panic is 100%`
`reproducible with a suspend duration >=3D 1 minute. Shorter durations`
`do not trigger the panic.`

`The bug is a regression: it does NOT occur with the Rocky Linux 10.1`
`kernel under identical conditions. Blacklisting iTCO_wdt and`
`iTCO_vendor_support in the guest completely eliminates the panic.`

`Notably, the host CPU is AMD Ryzen, meaning iTCO is purely a QEMU`
`emulated device with no real Intel TCO hardware involved.`

`=3D=3D Panic Call Trace =3D=3D`

`[ =C2=A0 95.753169] Kernel panic - not syncing: watchdog pretimeout event=
`
`[ =C2=A0 95.764046] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12=
.0-211.26.1.el10_2.x86_64 #1`
`[ =C2=A0 95.770099] Hardware name: QEMU Ubuntu 24.04 PC (Q35 + ICH9, 2009=
), BIOS 1.16.3-debian-1.16.3-2`
`[ =C2=A0 95.774960] Call Trace:`
`[ =C2=A0 95.776311] =C2=A0<IRQ>`
`[ =C2=A0 95.779071] =C2=A0dump_stack_lvl+0x4e/0x70`
`[ =C2=A0 95.780023] =C2=A0vpanic+0xc2/0x290`
`[ =C2=A0 95.781436] =C2=A0panic+0x6c/0x6c`
`[ =C2=A0 95.783045] =C2=A0pretimeout_panic+0x15/0x20`
`[ =C2=A0 95.784403] =C2=A0watchdog_notify_pretimeout+0x32/0x50`
`[ =C2=A0 95.786789] =C2=A0watchdog_hrtimer_pretimeout+0x15/0x20`
`[ =C2=A0 95.789221] =C2=A0__hrtimer_run_queues+0x13c/0x2a0`
`[ =C2=A0 95.791593] =C2=A0hrtimer_interrupt+0xff/0x230`
`[ =C2=A0 95.793728] =C2=A0__sysvec_apic_timer_interrupt+0x55/0x100`
`[ =C2=A0 95.796387] =C2=A0sysvec_apic_timer_interrupt+0x6c/0x90`
`[ =C2=A0 95.798942] =C2=A0</IRQ>`
`[ =C2=A0 95.800091] =C2=A0<TASK>`
`[ =C2=A0 95.803047] =C2=A0asm_sysvec_apic_timer_interrupt+0x1a/0x20`
`[ =C2=A0 95.803047] RIP: 0010:default_idle+0xf/0x20`
`[ =C2=A0 95.826719] =C2=A0default_idle_call+0x29/0xf0`
`[ =C2=A0 95.827574] =C2=A0cpu_startup_entry+0x29/0x30`
`[ =C2=A0 95.828663] =C2=A0rest_init+0xcc/0xd0`
`[ =C2=A0 95.829644] =C2=A0start_kernel+0x435/0x440`
`[ =C2=A0 95.840922] ---[ end Kernel panic - not syncing: watchdog pretime=
out event ]---`

`=3D=3D Root Cause =3D=3D`

`The issue is in drivers/watchdog/iTCO_wdt.c, in the suspend path.`

`The driver comment (line ~595) states:`

=C2=A0 `"In ACPI sleep states the watchdog is stopped by the platform firm=
ware."`

`Based on this assumption, need_suspend() only returns true for S0`
`(suspend-to-idle), leaving non-S0 states to firmware:`

=C2=A0 `static inline bool __maybe_unused need_suspend(void)`
=C2=A0 `{`
=C2=A0 =C2=A0 =C2=A0 `return acpi_target_system_state() =3D=3D ACPI_STATE_=
S0;`
=C2=A0 `}`

=C2=A0 `static int __maybe_unused iTCO_wdt_suspend_noirq(struct device *de=
v)`
=C2=A0 `{`
=C2=A0 =C2=A0 =C2=A0 `p->suspended =3D false;`
=C2=A0 =C2=A0 =C2=A0 `if (watchdog_active(&p->wddev) && need_suspend()) {`
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `ret =3D iTCO_wdt_stop(&p->wddev);`
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `if (!ret)`
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `p->suspended =3D true;`
=C2=A0 =C2=A0 =C2=A0 `}`
=C2=A0 =C2=A0 =C2=A0 `return ret;`
=C2=A0 `}`

`This assumption is valid on physical machines. However, under KVM:`

=C2=A0 `- "virsh suspend" causes QEMU to freeze the VM process directly`
=C2=A0 `- There is no real ACPI S3 transition`
=C2=A0 `- There is no platform firmware to stop the watchdog`
=C2=A0 `- need_suspend() returns false (target state is not S0)`
=C2=A0 `- iTCO_wdt_suspend_noirq() does NOT stop the watchdog or its hrtim=
er`
=C2=A0 `- After resume, the pretimeout hrtimer has already expired`
=C2=A0 `- pretimeout_panic() fires immediately`

`An additional anomaly: /sys/class/watchdog/watchdog0/pretimeout reads "0"=
,`
`which should prevent the pretimeout path from being entered at all.`
`Yet the panic still occurs via watchdog_hrtimer_pretimeout, suggesting`
`the driver's internal pretimeout hrtimer state becomes inconsistent`
`after KVM suspend/resume.`

`=3D=3D Reproduction Steps =3D=3D`

`1. Create a KVM guest (Q35 machine type) with iTCO watchdog:`
=C2=A0 =C2=A0 =C2=A0`libvirt XML: <watchdog model=3D"itco" action=3D"reset=
"/>`

`2. Boot Rocky Linux 10.2 (6.12.0-211.26.1.el10_2) as the guest`

`3. Confirm in guest:`
=C2=A0 =C2=A0 =C2=A0`lsmod | grep iTCO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 # iTCO_wdt loaded`
=C2=A0 =C2=A0 =C2=A0`cat /sys/class/watchdog/watchdog0/pretimeout =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0# 0`
=C2=A0 =C2=A0 =C2=A0`cat /sys/class/watchdog/watchdog0/pretimeout_governor=
 # panic`

`4. Suspend the host for >=3D 1 minute:`
=C2=A0 =C2=A0 =C2=A0`systemctl suspend`

`5. Resume: guest panics within ~60-95 seconds after resume`

`=3D=3D Suggested Fix Direction =3D=3D`

`need_suspend() should also return true when running under a hypervisor,`
`since no real ACPI firmware will stop the watchdog during guest suspensio=
n:`

=C2=A0 `static inline bool __maybe_unused need_suspend(void)`
=C2=A0 `{`
=C2=A0 `#ifdef CONFIG_ACPI`
=C2=A0 =C2=A0 =C2=A0 `/*`
=C2=A0 =C2=A0 =C2=A0 =C2=A0`* Under a hypervisor there is no real platform=
 firmware to stop`
=C2=A0 =C2=A0 =C2=A0 =C2=A0`* the watchdog during non-S0 sleep states, so =
handle it ourselves.`
=C2=A0 =C2=A0 =C2=A0 =C2=A0`*/`
=C2=A0 =C2=A0 =C2=A0 `if (boot_cpu_has(X86_FEATURE_HYPERVISOR))`
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `return true;`
=C2=A0 =C2=A0 =C2=A0 `return acpi_target_system_state() =3D=3D ACPI_STATE_=
S0;`
=C2=A0 `#else`
=C2=A0 =C2=A0 =C2=A0 `return true;`
=C2=A0 `#endif`
=C2=A0 `}`

`Alternatively, unconditionally cancel the pretimeout hrtimer in`
`iTCO_wdt_suspend_noirq() regardless of need_suspend().`

`=3D=3D Workaround =3D=3D`

`Blacklist the driver in the guest:`

=C2=A0 `echo "blacklist iTCO_wdt" >> /etc/modprobe.d/blacklist-watchdog.co=
nf`
=C2=A0 `echo "blacklist iTCO_vendor_support" >> /etc/modprobe.d/blacklist-=
watchdog.conf`
=C2=A0 `dracut --force && reboot`

`Thanks for looking into this.`

-----------------------c380fa9476170469f27749931ade3dee--

--------cb3d5b28620ffa16497a0d5f42169376b33ecc31660d0ee91ea93263387ff6b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmpEf1EJELgw/5TQrx/dRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfblXlkNXYVl+3y0d4PZKNQNlGJMEIzdaDCDdlZ
gn8PnBYhBAJJ3tK9zcplXafewbgw/5TQrx/dAADmCQD+KfURAa9fxrNs8hyW
/4QS64O2EtbSXnFyNEMotJ1QkUEBANffKmqDkFFcUWfoNZoSBfpFpVOa5Iax
uQx7gCfihZoD
=m+XD
-----END PGP SIGNATURE-----


--------cb3d5b28620ffa16497a0d5f42169376b33ecc31660d0ee91ea93263387ff6b5--

