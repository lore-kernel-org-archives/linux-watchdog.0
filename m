Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F5336EDA;
	Thu, 10 Sep 2026 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020977; cv=none; b=sVUnKZk+v+geXmkkwSTyh23WWL8v+lDHBM8T3pHh41uitEIHvnITwKK+FDRJns7zcWf01064zyAVhiZUx9ZivQDoAiHUhF8PW+FB4aqKHaIywCXwnEeoeRG+/neueEZBO5ee1xp3fACBfJXe1Nkj+DSP8kpGyKaQPSakHDePsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020977; c=relaxed/simple;
	bh=qrxc/7Oog3gqBDDTkCKt+BTeOzQQPqNSQKv4OvPekCg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=II1lAOtv7JYcdLBZzcYgGpWZj8+kf9hV5l4SAlP39lko6mDruF3afEZEPvtrJtlfph3FjPDeKLr3cL6KVV+y7aAShZCFVuBSDnVgliGK3SJRehH+SeG9bkAYvSZE5dgA0HQI0cjN00YJ43XrDW1AbAWkEj+4Vf6aC5FlSu5Iok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvTN8V1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvTN8V1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B651F000FF;
	Thu, 10 Sep 2026 06:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789020961;
	bh=z37+gWReZh8poMDSrM7YkJxySwWXYwEl7OL/mi5UdYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvTN8V1Wf+43m7FwMbuRFm+Ibv/3Q5+kNxwAj7Zeg9LSszRcoIyZ5+6l9KHe477s1
	 wUGql+InopnhUiT6PJ+PF6qd5mXfyDrQvC6NTjn/dxF2cf/PRPkbyRuQEIzi6wcWlv
	 jwMikTj5iiYrCFHnvKXOo+j3+ZwjII5nxdOpQBVRMjAo6S+F25cVdfunhRRM0ub+gH
	 o94J6rwdwPDgWOWMDXxEk3/HCnF1/9KOoG8FUezgjMAd7yB1BigR+5ZcCwx37fnk5G
	 4Xc1Fo9Y2Dv+iHLvan7lWzSTl5tGl0hRXPghg1n9MdISkjheoxS2QYEp3OoBNGh8ji
	 XjpDenytRX4ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260910060912.2443551-2-shivprakash.gupta@nxp.com>
References: <20260910060912.2443551-1-shivprakash.gupta@nxp.com>
 <20260910060912.2443551-2-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 06:16:00 +0000
Message-Id: <20260910061601.22B651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `interrupt-names` property schema incorrectly rejects valid =
hardware configurations where only INTB is connected.
--

commit 620f353657ea4242bf73ac8431d118e755e9de62
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: dt-bindings: rtc: Add NXP PCF8525 RTC

This commit adds a Devicetree binding for the NXP PCF8525 I2C RTC. It=20
describes properties for the device, including the optional INTA and INTB=20
interrupts, crystal load capacitance, and temperature-compensation model.

> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml b/Doc=
umentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
> new file mode 100644
> index 0000000000000..bee71ec3da808
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
> @@ -0,0 +1,86 @@

[ ... ]

> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      INTA, followed by INTB when both interrupt outputs are connected.
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: inta
> +      - const: intb

[Severity: Medium]
Does this interrupt-names array definition inadvertently prevent
configurations where only intb is connected?=20

Using an items array with - const: inta at the first position and
- const: intb at the second strictly requires the first item to be inta
during dt_binding_check schema validation.

If a device tree author specifies a single interrupt and uses
interrupt-names =3D "intb" because only the INTB pin is routed to the SoC
(for example, to be used solely for the watchdog), this schema will reject =
it.

Would it be better to use oneOf to explicitly permit the valid combinations,
or define the items using an enum so that intb is permitted at the first
index?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910060912.2443=
551-1-shivprakash.gupta@nxp.com?part=3D1
