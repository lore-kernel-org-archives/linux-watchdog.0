Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677968;
	b=jg2l20/9RNw4H4/5NPVvo0qSFGytdmr6fqKbaBIwVToq87VFXzWRDN7OBMvPOtBl5uMT
	 DlIMLZtxWOTWf7/Fk+F/b/8wgVPmaYwD9wCaIxHBc49rx06PJA4yblJUFnSpQfaSVVuvR
	 ffrNbPkEPFg+FZVbcnJ6BCyeT2Ak1rkndYkSho5HjLvxWSNgQ1KMpZ/e65se0kq79Cf2E
	 pxAXNCTSRtKpurm6qTxLMRdkVUn8wNYN6JAeySi+EHLX6Kzs2oIQGn9BWMgdgYrV4mMJf
	 Ik/rCDo0t9ldv0vrtfZue7DUCEfIuDEbU9yVQUvakf9zji4OK1cTHPbeZCWoZsHF+Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677968;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vwPiYQw1/RQ3JkyqFraLnyfc1cb8omjpoxuUpBC9ZuU=;
	b=S0MGIOP36yLnoQTkDhyvpOToCLhsRNrfia5h0aFWENDg0D/wLF9A8I4IemzZmw2jVrcy
	 91CWy31QrFcDdTNvgcrRbuudE1ZX0JH2+OXcgybEq17HFTTdudXQW4sBtVhe9FiXc7wd+
	 mCuJpKK19gpIttM/VOEVuJyLGAx0OfCRx+NPscJaa36IIpq1iL5aEE46AsHQRqJjbX0u9
	 RZfJ533Xk7tbtenPfxnrvQ5AMAI31Bwtg8acFWgzbAKcGwNQ+PXQYIdjx5NHCxcF/jaLa
	 Hmk/b00qMHyE8XuMxHhGqIhIAer+waOz5H/8+NIvvpAd71lxptYWryfFEBHFUQL+beQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUDs8ZWW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA6606A31C;
	Thu, 26 Nov 2026 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUDs8ZWW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B85C1F000C4;
	Thu, 26 Nov 2026 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795677968;
	bh=vwPiYQw1/RQ3JkyqFraLnyfc1cb8omjpoxuUpBC9ZuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EUDs8ZWWfbh34eobfcu2rIexLgdoJBvLRXEDvQwGmvihbV//Ial7ugnD7CJSE9J2Q
	 6KWUOKZ6hkf48ekLqcSob24tX23+pyE9aIv0Okckpg+DCDNEh1khcVNHK6SSRDSqeu
	 GPZ0wbw37NApRhmzhs1dr19D5ja5kDXzGvgzDNZikq7tvWLCSa9HGJFECgZNmvj212
	 k9st3GBoXJch+22fjNW2+jy2Vf/lXW4TL+zZOefR7Qrd6g5Jt/xmVxqddFZaMFwxSf
	 mefn0+IxqerayJypvPTkap7ruekjyM6V6qy5GoCwdJG2pR7yMLMNG8L/5fh2hUDHTZ
	 lLWwcV4c9jH5g==
Message-ID: <sashiko-outbox-234953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] rtc: pcf8525: Add watchdog support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261126071124.2383368-4-shivprakash.gupta@nxp.com>
References: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
 <20261126071124.2383368-4-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:26:07 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] rtc: pcf8525: probe failure in pcf8525_get_intb_irq() on
  single-IRQ DT nodes
--

commit 30bd2f8be3e00c36f24f374f227c2546b036b58f
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add watchdog support

This commit adds optional alarm-only watchdog support to the NXP PCF8525
RTC driver using the INTB interrupt line.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index 2b23b17d6750c..25420e7ad21c8 100644
> --- a/drivers/rtc/rtc-pcf8525.c
> +++ b/drivers/rtc/rtc-pcf8525.c

[ ... ]

> @@ -719,6 +978,31 @@ static int pcf8525_get_inta_irq(struct i2c_client *c=
lient)
>  	return client->irq;
>  }
> =20
> +static int pcf8525_get_intb_irq(struct i2c_client *client)
> +{
> +	struct fwnode_handle *fwnode =3D dev_fwnode(&client->dev);
> +	int irq;
> +
> +	irq =3D fwnode_irq_get_byname(fwnode, "intb");
> +	if (irq >=3D 0 || irq =3D=3D -EPROBE_DEFER)
> +		return irq;
> +
> +	if (irq !=3D -ENOENT && irq !=3D -EINVAL && irq !=3D -ENODATA &&
> +	    irq !=3D -ENXIO)
> +		return irq;
> +
> +	if (fwnode_property_present(fwnode, "interrupt-names"))
> +		return 0;
> +
> +	/* With no interrupt-names, INTB is the optional second interrupt. */
> +	irq =3D fwnode_irq_get(fwnode, 1);
> +	if (irq =3D=3D -ENOENT || irq =3D=3D -EINVAL || irq =3D=3D -ENODATA ||
> +	    irq =3D=3D -ENXIO)
> +		return 0;
> +
> +	return irq;
> +}

[Severity: High]
Does fwnode_irq_get(fwnode, 1) fail pcf8525_probe() on Device Tree nodes
that specify a single interrupt without interrupt-names?

When the interrupts property has only one entry, fwnode_irq_get() ->
of_fwnode_irq_get() -> of_irq_get() -> of_irq_parse_one() ->
of_property_read_u32_index() -> of_find_property_value_of_size() returns
-EOVERFLOW because the property exists on the node with a length smaller
than index 1 requires.  Since -EOVERFLOW is not mapped to 0 here,
pcf8525_get_intb_irq() returns -EOVERFLOW and aborts pcf8525_probe().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126071124.2383=
368-1-shivprakash.gupta@nxp.com?part=3D3
