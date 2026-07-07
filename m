Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA593DE45B
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420175; cv=none; b=VYOvKc+mpLJqCHSnxnDOEmiMDsIV0wtpCv0sIFTd9Z7W68AYg9lDfShfMBRlzlp9RzGMEJtdrW/r46hx5BPfQWGEvKc0Y4EZJlSirEssSj5BQDDXWZFCqbIinduLr4lpnWd6F6UK/MKDKJlwljIrgLWFsYTNKQz0KfBjbeAm7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420175; c=relaxed/simple;
	bh=wc1Ff3GjMWl4n25BeLXwpdV5EZjQc7/mJuh1ckwh/vQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sfQ0y3hnoSndzZLFp1fUpgntFG4bzG6CGAMJBV/rPexSTECjFUEJ72MLTEa2OWIFib4OQFn046spg69mdc2nN4LmkjkEceXpiLdp+j0qOs5n/XwtUBRaUrwDnjNAukfDQGJfPj/78xvlk2FecoGtIyoKeo7L7OMsNBiAabI/9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8N1TP2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8N1TP2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C2C1F000E9;
	Tue,  7 Jul 2026 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420171;
	bh=9CaiN0E12TVu2pddwX9Wgx2vfs0NahzFmpOAvOb4Vp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m8N1TP2HnMVMTzLqi6uFsfh5osBSf6nFDbRLwwpHxJYDrsfGc3iK6JvDT6C/NmTZl
	 8vrOMCkwB13xo4dyqFSt/kX1ZsZ9VO6MHzf6JWtqWvDWKlQ8ZXdT/GeuBKfZUN0s3/
	 Ye5WPC2bE/X54+m9iD3yb9pbwJ3Arqw/snufk3uRnmh/YlZq1cduzh4wxtbyBy0TZ7
	 SN4vRZGLo48PpnB/LURqPI94jU6bwArmQJeTQTKqyy1tgNpFUQszBk7EK7sTthcujl
	 5e5oD6+x1oS4EajpSKhwmvgZjeCS2O1eoMX+ea56a+EIJQ0K6iRXyJGiZxe5Eq2WfS
	 TvZ/g98iykW2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: pretimeout: Fix UAF in
 watchdog_unregister_governor()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260707101803.3598173-1-tzungbi@kernel.org>
References: <20260707101803.3598173-1-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:29:30 +0000
Message-Id: <20260707102931.06C2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A teardown symmetry violation in `watchdog_dev_unregister()` expos=
es a race window with sysfs, allowing a Use-After-Free of governor modules.
- [Medium] A sysfs race condition during device registration allows user-co=
nfigured pretimeout governors to be silently overwritten by `default_gov`.
--

--- Patch [1]: [PATCH] watchdog: pretimeout: Fix UAF in watchdog_unregister=
_governor() ---
commit f31dd8ccfc4553641fb99ced744ddc61a7ad970c
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: pretimeout: Fix UAF in watchdog_unregister_governor()

When a watchdog governor is unregistered, it updates existing watchdog
devices using it to fall back to default_gov. This commit clears
default_gov if it matches the governor being unregistered to prevent
two use-after-free scenarios where a dangling pointer is inherited.

> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/wa=
tchdog_pretimeout.c
> index 19eb2ed2c7cb0..02e09b9e396da 100644
> --- a/drivers/watchdog/watchdog_pretimeout.c
> +++ b/drivers/watchdog/watchdog_pretimeout.c
> @@ -167,6 +167,8 @@ void watchdog_unregister_governor(struct watchdog_gov=
ernor *gov)
>  	}
> =20
>  	spin_lock_irq(&pretimeout_lock);
> +	if (default_gov =3D=3D gov)
> +		default_gov =3D NULL;
>  	list_for_each_entry(p, &pretimeout_list, entry)

[Severity: High]
This is a pre-existing issue, but is there a teardown symmetry violation in
watchdog_dev_unregister() that exposes a race window with sysfs?

If watchdog_dev_unregister() calls watchdog_unregister_pretimeout() before
watchdog_cdev_unregister():

drivers/watchdog/watchdog_dev.c:watchdog_dev_unregister() {
	watchdog_unregister_pretimeout(wdd);
	watchdog_cdev_unregister(wdd);
}

The device is removed from pretimeout_list, but the sysfs interface is still
active. A concurrent write to the pretimeout_governor sysfs node can
successfully assign a governor to wdd->gov:

drivers/watchdog/watchdog_pretimeout.c:watchdog_pretimeout_governor_set() {
	spin_lock_irq(&pretimeout_lock);
	wdd->gov =3D priv->gov;
	spin_unlock_irq(&pretimeout_lock);
}

If the governor module is then unloaded, watchdog_unregister_governor() fai=
ls
to clear wdd->gov because the device is no longer in pretimeout_list. If an
in-flight hardware watchdog pretimeout interrupt fires,
watchdog_notify_pretimeout() dereferences the dangling wdd->gov pointer:

drivers/watchdog/watchdog_pretimeout.c:watchdog_notify_pretimeout() {
	wdd->gov->pretimeout(wdd);
}

Can this lead to a use-after-free?

>  		if (p->wdd->gov =3D=3D gov)
>  			p->wdd->gov =3D default_gov;

[Severity: Medium]
This is also a pre-existing issue, but does watchdog_dev_register() silently
overwrite user-configured pretimeout governors due to a sysfs race conditio=
n?

When watchdog_dev_register() is called, it registers the character device a=
nd
sysfs interfaces before fully initializing the internal pretimeout state:

drivers/watchdog/watchdog_dev.c:watchdog_dev_register() {
	ret =3D watchdog_cdev_register(wdd);
	if (ret)
		return ret;

	ret =3D watchdog_register_pretimeout(wdd);
}

If a userspace udev rule or concurrent process immediately writes to the
pretimeout_governor sysfs node, setting wdd->gov, the subsequent call to
watchdog_register_pretimeout() unconditionally overwrites it with default_g=
ov
without synchronizing with sysfs:

drivers/watchdog/watchdog_pretimeout.c:watchdog_register_pretimeout() {
	spin_lock_irq(&pretimeout_lock);
	list_add(&p->entry, &pretimeout_list);
	p->wdd =3D wdd;
	wdd->gov =3D default_gov;
	spin_unlock_irq(&pretimeout_lock);
}

Could this result in the user's requested governor being silently ignored?

>  	spin_unlock_irq(&pretimeout_lock);
> =20
>  	mutex_unlock(&governor_lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707101803.3598=
173-1-tzungbi@kernel.org?part=3D1
