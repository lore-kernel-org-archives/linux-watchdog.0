Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475464C1505
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578713; cv=none; b=Uwx6d4+0R7g+DAlEQ9hFqvswtuwr8Y2z/6rJ60NI7UCOPFb1W/ReDUXhHrgdK3tpgO+sSbFVnc+c00jHU1zIjYSJqZOm5XzQskFbOwo54dgUBYFrxzs3ReDYyGdeO409+DVQt7fE8RMyCJnDhgNg+BTUBo2bGHLUGCbg5b/E/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578713; c=relaxed/simple;
	bh=ZnWnFhxuUH8mxiv8e3zmB0zJVoi98pWVrCFuAaNfGI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jZqz/Ydj+YiFze4qn/gjpczCCJhinpdd21H8UGIwJq3i0lS82xKWg+Ss9bezZoZygktuZk1yWSCC0djE75iaV5ehtF2p2zd+70oonQvTjHXSl2tYobi/47ACPZAmkLL9l3MCQvOxj2NBh2up3hX9/M3ud1gHAzXgC+jVmWNP5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxfSdeFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxfSdeFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC041F000FF;
	Wed, 16 Sep 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578701;
	bh=bfdhipYSQ93LYNHqDYHLjQCZGD2tI3GbPImqgN5BbSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MxfSdeFGypfoXvPCnCskgRRX4jy8wwkL1bt6N31N1TIci7mCMsc2k1m5hGN7OKTTZ
	 fy1Y9ZRBSvdIgFXFLYMlJpIBm7GfG23nAqJ4yQqEI+n7ZS3N3yigYt6ydC3+Cs5+DD
	 JGFrZbmErd7Ez+1fAn0CzL61Ub97CY2GU2TyS/ESb1tB8Rh09QDHxQ48hkZ/1gaQCF
	 5kPV4qWBKrWDaBmGpvUZdwU/+QwnhlQSLYJTworUBiVkEoVs/v2t+7Viyc+7rbioap
	 CGHQX9afxNnUFzlcqGqFxzzSW+wQL6zbCM/Sqw7oBU3uTDmp/AhuovcaZvoH80Vz6Z
	 M7yGWm9qirIyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: nv_tco: Fix pci_dev reference leak in
 nv_tco_getdevice()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260916170240.2086046-1-vulab@iscas.ac.cn>
References: <20260916170240.2086046-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 17:11:41 +0000
Message-Id: <20260916171141.8BC041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: nv_tco: UAF of tco_pci in nv_tco_getdevice() after rebind
--

commit ebd2445ef6099c554744a2027e93f0a0d26346d1
Author: Wentao Liang <vulab@iscas.ac.cn>

watchdog: nv_tco: Fix pci_dev reference leak in nv_tco_getdevice()

This commit addresses a pci_dev reference leak in the nv_tco driver. It adds
pci_dev_put() calls to the error paths of nv_tco_getdevice() and also inside
nv_tco_cleanup() to properly drop the reference when the driver is removed =
or
encounters an error.

> diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
> index f16cee5173d50..9ce8325b4d3fd 100644
> --- a/drivers/watchdog/nv_tco.c
> +++ b/drivers/watchdog/nv_tco.c
[ ... ]
> @@ -373,6 +373,9 @@ static unsigned char nv_tco_getdevice(void)
>  	return 1;
>  out:
>  	release_region(tcobase, 0x10);
> +err:
> +	pci_dev_put(tco_pci);
> +	tco_pci =3D NULL;
>  	return 0;
>  }
> =20
> @@ -443,6 +446,7 @@ static void nv_tco_cleanup(void)
>  	/* Deregister */
>  	misc_deregister(&nv_tco_miscdev);
>  	release_region(tcobase, 0x10);
> +	pci_dev_put(tco_pci);

[Severity: High]
Is tco_pci left as a dangling pointer here?

If the driver is unbound, nv_tco_cleanup() drops the reference. Since it is=
n't
set to NULL here like it is in nv_tco_getdevice(), a subsequent rebind atte=
mpt
could lead to a use-after-free.

If no matching PCI device is found during re-initialization, the stale
pointer bypasses the check and is dereferenced:

drivers/watchdog/nv_tco.c:nv_tco_getdevice() {
    ...
    if (!tco_pci)
        return 0;

    /* Find the base io port */
    pci_read_config_dword(tco_pci, 0x64, &val);
    ...
}

Could this cause memory corruption when the underlying PCI device is
hot-removed and the platform driver is rebound?

>  }
> =20
>  static void nv_tco_remove(struct platform_device *dev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916170240.2086=
046-1-vulab@iscas.ac.cn?part=3D1
