Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885838AC8C;
	Fri,  7 Aug 2026 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092481; cv=none; b=G1oAIyjiF44UIzbwUnAXka2b5gE07rDhhCCAYFX6wv2vCjPjodwV30f9j+1uYx6l2j6OrVwI/2HvDZmtNc1SzqrzVTV3YlE5TzqPBLOyA9M/53bIV5+/VDhMH+1jlefSqbky9tG+75z322KeW0a7bO6OgqS5S/jTzosTBs9uASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092481; c=relaxed/simple;
	bh=1aofuFOg+HNUXsvxvrgyMkjAuMZnQ290T9nN65ZBqpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VIsuXxg0UFRoKxwoK7yotFf5F5hH0TXGGjPm41JrH+Z41hmkynP1Apa0owharRhSJp0ds47XafHtwDYwuhCPgpgfAJjkD7d/NoE7pAfSV8w4ooLwU6djTHEqCKzag//ITyRUq0HvDJ+bnH4Zqvrbv0m1hDNaoMwM04OH50tmMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGKz9FNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGKz9FNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FE91F000E9;
	Fri,  7 Aug 2026 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092479;
	bh=gJCLb3it6lbOvQ3+VAMUOu6MRnWbKzY7QCyTJnfRuls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGKz9FNj1xzNp4LaeFJbpJUp3xsQeW2f/pfYwUD8n+5xFbSTnnTuwwJhRuRsQ4MQb
	 eLmgjeHtfI3LHIm/18877fRW89ofriVmvSfJIZBUvSNo5xnmr7ptIPIU8vzdpRCshs
	 PUAze557+58gwZ+edPDdpzm2mzYA7d+RG87CeloR7qtUWxrzhGXWNyAcPzVGMdP9wK
	 BBX/B0a94OzHTO4rI6YmdOKMJQ8/oWHlPuu2hS6pmQ6tfoY8KZ0iQZxBkZoFtRJjyJ
	 locD0ZwIEzGlbxcsNjgHob+/BImHGVhTWSMHOSX3OtQtQPTk7ztuAkZVruk+14My2N
	 reHBHYnA0dPTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-hwmon@vger.kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260807082855.3762394-2-shivprakash.gupta@nxp.com>
References: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
 <20260807082855.3762394-2-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:47:58 +0000
Message-Id: <20260807084759.50FE91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `interrupt-names` schema strictly requires the first interru=
pt to be `inta`, incorrectly rejecting a configuration where only a single =
`intb` interrupt is connected.
--

--- Patch [1]: [PATCH 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC ---
commit edd4cb5090a8c1765775edd3168f097a2f181903
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

dt-bindings: rtc: Add NXP PCF8525 RTC

This commit adds a Devicetree binding for the NXP PCF8525 I2C RTC. It
describes optional inta and intb interrupts alongside properties for
external crystal load capacitance and temperature-compensation crystal
models.

> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml b/Doc=
umentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
> new file mode 100644
> index 0000000000000..bee71ec3da808
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml

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
Will this strictly require the first interrupt to be inta, rejecting a
configuration where only a single intb interrupt is connected?

If a board designer creates a device tree node with a single interrupt and
sets interrupt-names to intb, the schema's items list imposes strict
positional constraints requiring the first element to be inta. This would
cause validation to fail for a valid hardware configuration where only the
intb pin is connected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807082855.3762=
394-1-shivprakash.gupta@nxp.com?part=3D1
