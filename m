Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F062C11DF
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411346; cv=none; b=JLXwKTpCQYjqyzlPgcLPRHl2fNEnc/x7JcBUhYuavIkn//DTtpZRA+n+lG15qSc4zV/be3tQOLgTXvo9t889ZfNcKAESsKsgqAZL4uU2kEqFqNt8j6hVDh4rxuknHD/9LWi4/Y51MGLaYUYBQ6OkQOgrT1mLyJqQG7leDP9qkeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411346; c=relaxed/simple;
	bh=j61mVEIJzzks3mly3MK4Jiar0YJv4dtnhuqSYwv1FP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VgTwhkphcq5W0SAPatejPYPfb0ufLsXNY3TsBFeXE9RyaRl9vcm0506Px4fJj0fP9/7kDoyCjNjMhrNNHCK3zNESgVO/CcOzTGxg4FEF/KaleNGc3eKpMuguIUxGGPo2dFnJLa1W/KYLB1hewpy4SnefXLOI14MVzyo7ODbGkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7KfT2gE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7KfT2gE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C52D1F000E9;
	Tue,  7 Jul 2026 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783411345;
	bh=ol5MvAPTQMiISHIiptmccBHiOWZV0veRPEQS2lCEuPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7KfT2gEfA7NMqPorgPe8bv7PFr5xjzWCROSfDKL5Ul/Lcsdtfh8EKQ/TIz3Gbcw2
	 00YsJlk9IPO+/wVQYXvcaVR3D1Vie0Dlp3s2ZIgiepunP8QTiEZ4/dzCm4xkQfaURj
	 1O9sYBKs5HNfwMDk1MIlZ+lTyuQa+IyqakqAh34EoMR2+wPg12xI6fOYBA0AFCXFWL
	 m9JTpana7wZv4ZZ7H1EVblOJGPfNZt/4+5HaKT+RxZG2IPoy73MyL96EuhEVRU/iCa
	 5HDgp+M9qvM0FxW3X+mzz9lM2I5s/6qC0YmBLIVdYQ7w8udVUTx3nghyfB2+uZh2F+
	 EfOEqSEktELOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: pretimeout: Add "dump" pretimeout governor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260707073117.2962676-1-tzungbi@kernel.org>
References: <20260707073117.2962676-1-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:02:24 +0000
Message-Id: <20260707080225.4C52D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Compiling the new 'dump' pretimeout governor as a loadable module c=
auses a modpost build failure because `trigger_all_cpu_backtrace()` relies =
on an unexported symbol.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but unregistering th=
e default watchdog pretimeout governor leaves dangling pointers in `default=
_gov` and device structs, leading to a Use-After-Free (UAF) upon the next p=
retimeout event or sysfs read.
--

--- Patch [1]: [PATCH] watchdog: pretimeout: Add "dump" pretimeout governor=
 ---
commit dc8900cef0c7ac20c37ff84ef6166ddde30f5da7
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: pretimeout: Add "dump" pretimeout governor

This patch adds a new "dump" pretimeout governor that triggers a backtrace
of all CPUs to the kernel log buffer before the watchdog fires. It also
updates the Kconfig logic to fall back to the "panic" governor only when
both "noop" and "dump" governors are disabled.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 08cb8612d41fe..7b291ea8b0f01 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig

[ ... ]

> @@ -93,10 +93,19 @@ config WATCHDOG_PRETIMEOUT_GOV_SEL
> =20
>  if WATCHDOG_PRETIMEOUT_GOV
> =20
> +config WATCHDOG_PRETIMEOUT_GOV_DUMP
> +	tristate "Dump watchdog pretimeout governor"

[Severity: Low]
Will this fail to build if compiled as a module?

When CONFIG_WATCHDOG_PRETIMEOUT_GOV_DUMP=3Dm, trigger_all_cpu_backtrace() c=
an
rely on unexported architecture-specific functions (such as
arch_trigger_cpumask_backtrace() on x86, ARM, and ARM64), which causes a
modpost build failure.

> +	depends on WATCHDOG_CORE
> +	default WATCHDOG_CORE
> +	help

[ ... ]

> diff --git a/drivers/watchdog/pretimeout_dump.c b/drivers/watchdog/pretim=
eout_dump.c
> new file mode 100644
> index 0000000000000..c5d3dac2606c4
> --- /dev/null
> +++ b/drivers/watchdog/pretimeout_dump.c

[ ... ]

> +static void __exit watchdog_gov_dump_unregister(void)
> +{
> +	watchdog_unregister_governor(&watchdog_gov_dump);
> +}

[Severity: High]
This is a pre-existing issue, but does unregistering the default watchdog
pretimeout governor leave dangling pointers?

If this module is set as the default governor and then unloaded,
watchdog_unregister_governor() attempts to reset the active governors:

    list_for_each_entry(p, &pretimeout_list, entry)
        if (p->wdd->gov =3D=3D gov)
            p->wdd->gov =3D default_gov;

If the unregistered governor is the default governor, default_gov equals
gov. This leaves p->wdd->gov pointing to the unloaded module's struct.

Could this lead to a use-after-free upon the next pretimeout event or sysfs
read?

> +module_init(watchdog_gov_dump_register);
> +module_exit(watchdog_gov_dump_unregister);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707073117.2962=
676-1-tzungbi@kernel.org?part=3D1
