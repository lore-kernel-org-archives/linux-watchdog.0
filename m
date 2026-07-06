Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9136F8F5
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333320; cv=none; b=UCWDzjpppZuIGvyBCG/fU2XQOBIgs1cH+te43P4yOv6mYLmysknMzHJs4eJfln9kh4hB7oRTrHe6Ysn87YJOuPjAF7D2ZLreq02AqNvrIa50Id4SiGvbn3CeXEEtDrJ6GjhoEhXConcEtPq5HPtEm5Y6B7lEiOI9dQnX0zeGfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333320; c=relaxed/simple;
	bh=oWltj68bM7GKe8hMFHU9V0D2yR74dcbhbZ+W+oo99Gw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QdNV22x4juvSe5jaB25nfBkZZjZ+Sksvkt984VmEpkZPAh/2aTak4o610Rxqo/yH5ODFoc1fLbaeZ1BzvKP+/JpW5MTUW3KKKwQ+qejWosVjDjrLZAqxFjbeJXx9SUuxEdjB79Cw+S9RKstNrQMVtL6V9ZYidgZrkQaTMMO2c6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEhKo0YC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEhKo0YC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506A61F000E9;
	Mon,  6 Jul 2026 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333319;
	bh=FQjs/LCy3d9a0gqH3V1njTKD94BquTbka1IQ535xkcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gEhKo0YCYqbzeACbJa0YLMuj+HGmNYHNuoCQgCmCmIqEsk2TSJtBmkbZilhXrBgSz
	 YWrpMh2IhQdy9PnTnhzk8m3ZDSZwxhqNRus3e0p3CSHZDzZvsKiEgEv0HBeqkO5niY
	 sl/URmp/spZRR2gYUxCSJSFGe/qIJejomcN4v5vNEth2Mkhtz+cqA6XZV+ze/q+Fj4
	 Rt6PfC6cmp2JDd99fW2w7Y3YiZe84qju9uwz/9nJCKh0GIkZzvxMocHYAxZQtofl7H
	 OIdJxif/l/b+MDrkR90qJG166BsP0i363cyzTv3lLamOKLaT6fp1PrQrAkRJ0bL/uf
	 3qZ0/D3+vyvZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] watchdog: w83627hf_wdt: Add support for Nuvoton
 NCT6126
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v1-1-c5b0d51691c6@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v1-0-c5b0d51691c6@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v1-1-c5b0d51691c6@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:21:58 +0000
Message-Id: <20260706102159.506A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly added `nct6126` chip is missing from the `switch (chip)`=
 statement in `w83627hf_init()`, causing critical hardware watchdog initial=
ization (WDTO# output routing) to be skipped.
- [Low] The macro `NCT6116_ID` is redundantly defined twice in a row with t=
he identical value.
--

commit 0f99926a9f6fc9f6f9e5246a88211f0c8ad46b5b
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Add support for Nuvoton NCT6126

Add support for the hardware watchdog integrated in the Nuvoton NCT6126
Super I/O chip. This distinguishes the NCT6126 from the NCT6116 by reading
the low byte of the chip ID.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index bc33b63c5a5df..9533baa453841 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -49,7 +49,7 @@ static int wdt_cfg_leave =3D 0xAA;/* key to lock config=
uration space */
>  enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>  	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
>  	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
> -	     nct6795, nct6796, nct6102, nct6116 };
> +	     nct6795, nct6796, nct6102, nct6116, nct6126 };
> =20

[Severity: High]
Does this code miss handling the new nct6126 chip in w83627hf_init()?

When w83627hf_init() initializes the watchdog device, it uses a switch
statement on the chip type. Because nct6126 is omitted from the switch cases
in w83627hf_init(), it falls through to the default case:

drivers/watchdog/w83627hf_wdt.c:w83627hf_init() {
        ...
        switch (chip) {
        ...
        case nct6116:
                ...
                t =3D superio_inb(cr_wdt_control);
                t |=3D 0x02;      /* enable the WDTO# output low pulse
                                 * to the KBRST# pin */
                superio_outb(cr_wdt_control, t);
                break;
        default:
                break;
        }
}

Without nct6126 being added alongside nct6116, the WDTO# output initializat=
ion
is skipped. Will this cause the watchdog timer to count down and expire
without successfully triggering a physical system reset?

[ ... ]

> @@ -95,6 +95,9 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at bo=
ot time (default=3D0)");
>  #define NCT6776_ID		0xc3
>  #define NCT6102_ID		0xc4
>  #define NCT6116_ID		0xd2
> +#define NCT6116_ID		0xd2	/* also NCT6126D */

[Severity: Low]
This isn't a bug, but NCT6116_ID is now defined twice with the exact same
value. Was the intention to just add a comment to the existing definition
instead of redefining it entirely?

> +#define NCT6126_VER_A_LOW_ID	0x83	/* ... version A */
> +#define NCT6126_VER_B_LOW_ID	0x84	/* ... version B */
>  #define NCT6779_ID		0xc5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-w83627hf_w=
dt-nct6126d-v1-0-c5b0d51691c6@bootlin.com?part=3D1
