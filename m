Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC43B5821
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333809; cv=none; b=NL4Rm9LKf5jD9DapCNCICnpFPoRscMIfN2ueTLQyF/wJ3Hy42P9HKx+Vrp0Zogc2kczZ+LS2F/0LDHIK+ZjPDsAVuwoSlVCWfvSRd/QdyfBaS1BOXwAbebL3VLU3+zsIpCPl7EeiMgdE1D/KqOEh3E/lWPreWq2VDu5yhEy6Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333809; c=relaxed/simple;
	bh=kwkPcqj10f2cjGY89oMmo+osNjYfrtz66ul8H5em2bU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DOR/QVOuLUIXoPjIe+pEdUBVhXp4PbOKWESsIfciIHBUXyeg+ac0Pc5865O6TP0QYr44hhw6Vf8fU0+NtBrJnTbE1mE182upWV28dXWPZmP7k4tsj1Jgh+y1EflofpB+5OV08h0d8N2bFjazCOr40rgwhGRjmheTykBC23hSW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gry0h+So; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gry0h+So"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B561F000E9;
	Mon,  6 Jul 2026 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333808;
	bh=Tg8RNbDb9T9KZTOyIlFDM2a/7+VLk2sOWIMJ+ETcbD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gry0h+SokX5fLkdi0q/9XlDAbpb6vXHwQqkhs63ExWILELVbLsKXfmj+Rjo0sdzqv
	 uAKM5UVxZckgpH1e/NvWVelF3T6eW6afYWdS1uktoxmuENMqQBRIh5Lqhll/3XZjye
	 p25TxDr1gnA/dW99ZI13y3+GYm8yaMGaOjLWReSo3PzdDBUA2XAw+rnApyfK1Bjoni
	 W/b66QK4KUtvOUWoIAr2HRmsjIIBaGmMWeBlLiDvJqe3yz2PEgUsKiEBv/oVKtON5A
	 j5YAPhMGj/yZffECqaUmZhbMdi93LjLIG362plzVb0eMWXK3M7wvg7K3+G/s1Eoj8q
	 gCIOCzJZFqr6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: w83627hf_wdt: Add support for Nuvoton
 NCT6126
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v2-1-77af74af88ae@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v2-0-77af74af88ae@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v2-1-77af74af88ae@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:30:07 +0000
Message-Id: <20260706103007.D4B561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing hardware reset initialization for the NCT6126 watchdog chi=
p.
--

commit e0ddc629265e45d1982854f304eefd4e2a86e9dc
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Add support for Nuvoton NCT6126

This commit adds support for the Nuvoton NCT6126 hardware watchdog to the
w83627hf_wdt driver. It differentiates the NCT6126 from the NCT6116 by
checking the low byte of the chip ID.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index bc33b63c5a5df..1f649fda8a813 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c

[ ... ]

> @@ -428,7 +430,12 @@ static int wdt_find(int addr)
>  		cr_wdt_csr =3D NCT6102D_WDT_CSR;
>  		break;
>  	case NCT6116_ID:
> -		ret =3D nct6116;
> +		val =3D superio_inb(0x21);
> +		if (val =3D=3D NCT6126_VER_A_LOW_ID || val =3D=3D NCT6126_VER_B_LOW_ID)
> +			ret =3D nct6126;

[Severity: High]
Does this code miss updating the switch statement in w83627hf_init() to
include nct6126?

Looking at w83627hf_init(), the other NCT chips are explicitly handled to
enable the WDTO# output pulse:

drivers/watchdog/w83627hf_wdt.c:w83627hf_init() {
	...
	case nct6102:
	case nct6116:
		/*
		 * These chips have a fixed WDTO# output pin (W83627UHG),
		 * or support more than one WDTO# output pin.
		 * Don't touch its configuration, and hope the BIOS
		 * does the right thing.
		 */
		t =3D superio_inb(cr_wdt_control);
		t |=3D 0x02;	/* enable the WDTO# output low pulse
				 * to the KBRST# pin */
		superio_outb(cr_wdt_control, t);
		break;
	default:
		break;
	...
}

If nct6126 isn't added to this switch statement, it will fall through to the
default case.  Will this cause the chip to skip enabling the reset logic,
resulting in the watchdog timing out without physically resetting the syste=
m?

> +		else
> +			ret =3D nct6116;
> +
>  		cr_wdt_timeout =3D NCT6102D_WDT_TIMEOUT;
>  		cr_wdt_control =3D NCT6102D_WDT_CONTROL;
>  		cr_wdt_csr =3D NCT6102D_WDT_CSR;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-w83627hf_w=
dt-nct6126d-v2-0-77af74af88ae@bootlin.com?part=3D1
