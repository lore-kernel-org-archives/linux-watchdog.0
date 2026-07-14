Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F33355F46
	for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027146; cv=none; b=W9vdFK0alLPfKssVdecffVb0edqrW+FTj4IGv8RqJlqOPUL9yEl5pIqqUHIiA/iUSYXoNNPRJT45j1Wk2Yue7avVSEdakCPvQJs4GLZf9x6FOhMQHXF+ANLohcsYDrCibrYMJDRC0j+cZykiaHzat6dFQAox4A9H1DblhrTypis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027146; c=relaxed/simple;
	bh=6lPiymlTHxXzOwX2DrxBpPoheTDhd0D+C6Q5zjIG7+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RW/8DkZpmjA+9JjqJyJMhg/H2BM3yN5Iaj108D11CIe9ZGoNFZbVJQuk1fOWkNx4a/AuzIeVA2nlRjtiLmAWxR/eHZhJ68DkW7LlwjssfN3jzwmc/N0r/2ugudB7nIJ/6YMkzRIUR24d0wKAeaPyD0m3noOavMaWpUqyQ3/bhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkWqAg9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkWqAg9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D171F000E9;
	Tue, 14 Jul 2026 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784027145;
	bh=HEDKK2ilpBaR4D+GNqSnjnvIUbMAn1iS6hmSOE/qaMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OkWqAg9kJCWXn3KwZfOmhAv8EuiPqulg3CjHbtLa2sRUxZQ0+AMSMYDhaFd4JE0Mi
	 6lCjbu1iCgu44sG9ZRtUPdcQBHCjxJKMJcDomIrQFXSt+YzWn5Noi3SvOu+zP2jgl3
	 JXE1cpCRxYiKLNmrQEZ0jHtyyo1RbkQh/8TWIPX5LLciJHszeXyma5McOUeRCVz9Ln
	 kcaINTyT/KnGsFRowwWOeQrTawN0lZ4hfXBr82r69mWaMqWHZnzeuPK+HiJbiThR2+
	 4advLoIklCJHp1rqciCZ4gvzH6QAM56gzYOwxvd+RO/3cSIr0VM0qHsYL4kxlhqGRA
	 vf8Debrv2YiYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: take all OF aliases into account when
 assigning id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rasmus Villemoes" <linux@rasmusvillemoes.dk>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260714105356.2931450-1-linux@rasmusvillemoes.dk>
References: <20260714105356.2931450-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:05:44 +0000
Message-Id: <20260714110545.06D171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The fallback ID allocation for legacy watchdog modules bypasses =
the new alias-aware logic, potentially stealing an ID reserved by a DT alia=
s.

Pre-existing issues:
- [High] A pre-existing flaw in deferred watchdog registration ignores fail=
ures, leaving dangling pointers that trigger Use-After-Free and Double Free=
 vulnerabilities when the device is subsequently unbound.
--

--- Patch [1]: [PATCH v2] watchdog: take all OF aliases into account when a=
ssigning id ---
commit 723b5098283b03dc095379b11c599fe692046472
Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>

watchdog: take all OF aliases into account when assigning id

Ensure that ids for devices without a device tree alias are allocated
from among those where no watchdogX alias exists.

> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog=
_core.c
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c

[ ... ]

> @@ -265,8 +267,26 @@ static int ___watchdog_register_device(struct watchd=
og_device *wdd)
>  					     GFP_KERNEL);
>  	}
> =20
> -	if (id < 0)
> -		id =3D ida_alloc_max(&watchdog_ida, MAX_DOGS - 1, GFP_KERNEL);
> +	/*
> +	 * Find an id which is not pre-assigned via a DT alias to some
> +	 * other, possibly not yet probed, watchdog device.
> +	 */
> +	if (id < 0) {
> +		np =3D of_find_node_by_path("/aliases");
> +
> +		for (min_id =3D 0; ; min_id =3D id + 1) {
> +			id =3D ida_alloc_range(&watchdog_ida, min_id, MAX_DOGS - 1,
> +					     GFP_KERNEL);
> +			if (!np || id < 0)
> +				break;
> +
> +			snprintf(alias, sizeof(alias), "watchdog%d", id);
> +			if (!of_get_property(np, alias, NULL))
> +				break;
> +			ida_free(&watchdog_ida, id);
> +		}
> +		of_node_put(np);
> +	}
> =20
>  	if (id < 0)
>  		return id;
>  	wdd->id =3D id;
> =20
>  	ret =3D watchdog_dev_register(wdd);
>  	if (ret) {
>  		ida_free(&watchdog_ida, id);
>  		if (!(id =3D=3D 0 && ret =3D=3D -EBUSY))
>  			return ret;
> =20
>  		/* Retry in case a legacy watchdog module exists */
>  		id =3D ida_alloc_range(&watchdog_ida, 1, MAX_DOGS - 1,
>  				     GFP_KERNEL);

[Severity: Medium]
Does this fallback allocation for legacy modules need to validate against
DT aliases as well?

Because this path calls ida_alloc_range() directly, it bypasses the newly
introduced alias validation loop. If a legacy watchdog module causes a
retry, could this allocation steal an ID that is actively reserved for
another unprobed device via a DT alias?

[Severity: High]
This is a pre-existing issue, but I noticed a potential flaw in how
watchdog_deferred_registration() handles failures.=20

If the registration fails, the return value is ignored:

drivers/watchdog/watchdog_core.c:watchdog_deferred_registration() {
    ...
    __watchdog_register_device(wdd);
    ...
}

During the failed registration attempt, watchdog_cdev_register() assigns
wdd->wd_data, but never clears it on the error path:

drivers/watchdog/watchdog_dev.c:watchdog_cdev_register() {
    ...
    wd_data->wdd =3D wdd;
    wdd->wd_data =3D wd_data;
    ...
}

If this fails, the device is left in a partially initialized state but
remains registered in devres. When the device is subsequently unbound or
the module removed, __watchdog_unregister_device() executes on the failed
device:

drivers/watchdog/watchdog_core.c:__watchdog_unregister_device() {
    ...
    watchdog_dev_unregister(wdd);
    ida_free(&watchdog_ida, wdd->id);
    ...
}

Could this trigger a use-after-free or NULL pointer dereference inside
watchdog_dev_unregister(), as well as a double-free on the IDA since the
ID was already freed during the initial registration failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714105356.2931=
450-1-linux@rasmusvillemoes.dk?part=3D1
