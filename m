Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46F3CE4B5;
	Tue, 13 Oct 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875017; cv=none; b=Sg/F6RxB44Q8jOsyMBQ4UgIjTzdkUWqvqo8KxCdGRZMo8P1oYniqGlcms6j4pum97RMp1AwpAHJAUFtRp3WacxxNb640V/3k6eo74vecesNxZpaK0p2JZVcmW5YAphs7jQaFG1Xw3VtvCzxNs5FtNnlvB+DiSaORkALfMFqN+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875017; c=relaxed/simple;
	bh=+GkHhUFoHl24xkNvl//jHs5d+SUTjNgLF4a17pSlxD0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JhTGBiMRE8P7wuo65317kr4fapVgDRiUVusGwU8OikeWxCo1dEQyMt0+tj91CVtmZWUa/fZVWRABqN9YsomZa8tG/LOtfIVoHzBgJdtFn32Ge8ykapKS8Ce9xR44t/p4bMofnRMKvy1VgiO7jcJGqyTOJHl1zPgbec1OWXLaB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5xzRJtE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5xzRJtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469EB1F000FF;
	Tue, 13 Oct 2026 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791875016;
	bh=4lqjhpdu+A5kK9msUbydoo48CEzbPiUZcGuZ/DLuQ18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5xzRJtExvmuFIOJ7z/tXRIO84Y5bhw6RyPOLIc9O3RTLXv5DOee7xWa2+mwsTU+N
	 KYyb6YtbpZkA9i5GIJNtwa+svUk1ZixDSXNdLPHd/RibVd5ajSeIKhkPn+NxifhnJx
	 QYkFSEiQiZ3m43J5b+uAozln1RMWARTJKNVIl6vfG1hlJPjB0j3TigBGdefESQTtk3
	 YXYcZ9/mZBXmItqqZrWrvKBT0oTafWJ9ZqC24yXFsTdSavsaNhSCDV2x9K4HwTRkxQ
	 K0xBkeMUTnprtMzXW/JLm8aqd9q5+LNuUJbbt6FaG9Elvvtjd2AP8o/ajdwu+XIgLq
	 UiiSCfscFq1YQ==
Message-ID: <sashiko-outbox-169158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/11] watchdog: Add ARM TWD (MPCore private)
 watchdog driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013-b4-cs75xx-s2-v3-7-181bb0d23f4c@gmail.com>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-7-181bb0d23f4c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 07:03:35 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] watchdog: acquiring cpus_read_lock() in clock notifier causes dead=
lock
- [High] watchdog: arm_twd_wdt: watchdog silently disabled across cpuidle d=
eep sleep
- [High] watchdog: arm_twd_wdt: missed ping on concurrent clock rate change
--

commit 3df85baea3ae83b30f30fe157567af6f425f2a20
Author: Fil Dunsky <filipp.dunsky@gmail.com>

watchdog: Add ARM TWD (MPCore private) watchdog driver

This patch adds a watchdog driver for the ARM Cortex-A9/A5 and ARM11
MPCore private watchdog. It programs, pings and stops the watchdog on
all online CPUs and registers a hotplug state to handle CPUs coming
online and going offline.

> diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wd=
t.c
> new file mode 100644
> index 0000000000000..18875ae24a243
> --- /dev/null
> +++ b/drivers/watchdog/arm_twd_wdt.c
[ ... ]
> +static void twd_wdt_cpu_ping(void *data)
> +{
> +	struct twd_wdt *wdt =3D data;
> +
> +	/* In watchdog mode a write to the load register reloads the counter */
> +	writel(twd_wdt_ticks(wdt, wdt->wdd.timeout), wdt->base + TWD_WDT_LOAD);
> +}

[Severity: High]
Does this ping routine silently fail to re-enable the watchdog if the CPU
previously entered a deep cpuidle sleep state?

If cpuidle cuts power to the CPU's power domain, TWD_WDT_CONTROL might be
lost. Writing to TWD_WDT_LOAD alone without restoring TWD_WDT_CONTROL could
leave the watchdog permanently disabled upon wakeup.

[ ... ]
> +static int twd_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct twd_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +
> +	cpus_read_lock();
> +	on_each_cpu(twd_wdt_cpu_start, wdt, 1);
> +	wdt->armed =3D true;
> +	cpus_read_unlock();
> +
> +	return 0;
> +}

[Severity: High]
Could setting wdt->armed =3D true after calling on_each_cpu() cause a race
condition with a concurrent clock rate change?

Because this function uses a shared reader lock (cpus_read_lock()), it can
run concurrently with twd_wdt_clk_notify(). If the clock rate increases just
as the watchdog is started, twd_wdt_clk_notify() might see wdt->armed =3D=
=3D false
and skip resynchronizing the ping, resulting in the hardware running with a
timeout calculated for the old, slower clock rate.

[ ... ]
> +static int twd_wdt_clk_notify(struct notifier_block *nb, unsigned long e=
vent,
> +			      void *data)
> +{
> +	struct twd_wdt *wdt =3D container_of(nb, struct twd_wdt, clk_nb);
> +	struct clk_notifier_data *cnd =3D data;
> +	unsigned long rate;
[ ... ]
> +	cpus_read_lock();
> +	wdt->rate =3D rate;
> +	if (wdt->armed)
> +		on_each_cpu(twd_wdt_cpu_ping, wdt, 1);
> +	cpus_read_unlock();
> +
> +	return NOTIFY_OK;
> +}

[Severity: High]
Can acquiring cpus_read_lock() here cause an AB-BA deadlock with CPU
hotplug?

The clock framework's prepare_lock is already held when this notifier is
called. The CPU hotplug path acquires the global hotplug lock for writing
via cpus_write_lock() and invokes callbacks, including cpuhp_cpufreq_online=
().

Cpufreq drivers update CPU frequencies during hotplug by calling
clk_set_rate(), which acquires the clock framework's prepare_lock mutex,
establishing a locking order of cpu_hotplug_lock -> prepare_lock.

Acquiring cpus_read_lock() here creates an inverted lock order of
prepare_lock -> cpu_hotplug_lock.

[ ... ]
> +static int twd_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct twd_wdt *wdt;
> +	struct clk *clk;
> +	int ret;
[ ... ]
> +	ret =3D cpuhp_state_add_instance(twd_wdt_hp_state, &wdt->node);
> +	if (ret)
> +		return ret;

[Severity: High]
Is a call to cpu_pm_register_notifier() missing here to ensure the watchdog
context is saved and restored across deep CPU idle states?

Without this, the watchdog could remain disabled if TWD hardware loses its
state during deep sleep.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
s2-v3-0-181bb0d23f4c@gmail.com?part=3D7
