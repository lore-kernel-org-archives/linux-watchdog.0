Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7B29E0E5
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980940; cv=none; b=lKfyMbGyWaosnC6X7u2dNlMtUfS4gztsJdfB1zi8RTsUki8cwuSQgqsMfVcZcWDV9zynyWINXERgLIkHN32XOXdJz9c49xiAct9dFdSsDQxMyLO28ihBap3xwya2THGN+/MuiwhAMMQmxsVXKboXvDXrM/e1KQv/DpNySKQ9Zro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980940; c=relaxed/simple;
	bh=evDGA2xeXI/XfD8Hlia9tn4PVMmlUiE4Ot6DCwSJSPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oeP04EjK07rYQGcPIs6XPFic8xtEdfbm1GJJ9DWp5uL6mxVBvD70PDAroE3PgItXeG4/kRvFDIgtCliqadOq450Ohh3ZxGWZ0eP4RYHW1Yl3DDWXmVQ9X8QsQHSyRsRb75o7fCtCr5YHlJ/Iqszm9GRwQV+UWlvBucsaDjwJ3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsgvRQpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsgvRQpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2D6C2BCB4;
	Tue,  5 May 2026 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777980940;
	bh=evDGA2xeXI/XfD8Hlia9tn4PVMmlUiE4Ot6DCwSJSPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TsgvRQpybjktWMcegBBN+DWgNB90xlXxE506Isk4Xo2UKTxV53LyXKZBOjLKNlkGJ
	 K6pO9HsrIjvboPsRPymY1nVZhpZoEfZ+QPkouJOpFg5EDC3m0ZN3tevnvuaVrMl8xQ
	 jGATcFToKxmRQOhQs57KG1CSDjEQfYQHtGRCQEQHD180jU0f54JkgajItykweFX68i
	 ydo2ai4yPx0jHVwMOFIidWpWxU/kBlzUSGi88lvosHg0ZosdCL0VsZ3N+eHbHsIHzD
	 ENCz4/bkquaoGH4JhzyPjhLd/1yHJa0mHuL5W2RG8UWnU8UCnbTSaA77PH5vS2xN8w
	 4uK/RXCQrM7jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Reply-To: sashiko@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260505-apple-m3-initial-devicetrees-v2-3-b0c2f3519e0e@jannau.net>
References: <20260505-apple-m3-initial-devicetrees-v2-3-b0c2f3519e0e@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 11:35:39 +0000
Message-Id: <20260505113539.DD2D6C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added `apple,t8122-wdt` compatible string will not bind =
to the watchdog driver because the driver does not match `apple,t8103-wdt` =
and the schema prevents including the generic `apple,wdt` fallback.
--

commit c2fb9f5326f211450e3923c7641f1f6384822f86
Author: Janne Grunau <j@jannau.net>

dt-bindings: watchdog: apple,wdt: Add t8122 compatible

This commit adds the apple,t8122-wdt compatible string to the apple,wdt
device tree binding. It is added to the branch that restricts the fallback
to apple,t8103-wdt.

> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/=
Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index 05602678c070d..845b5e8b5abc3 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -16,7 +16,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: apple,t6020-wdt
> +          - enum:
> +              - apple,t6020-wdt
> +              - apple,t8122-wdt
>            - const: apple,t8103-wdt

Will this prevent the driver from probing on t8122 devices?

This schema requires exactly two compatible strings: apple,t8122-wdt
followed by apple,t8103-wdt. This exact match requirement prevents the
inclusion of the generic apple,wdt fallback string.

Looking at drivers/watchdog/apple_wdt.c, the driver's of_match_table only
matches { .compatible =3D "apple,wdt" } and does not match apple,t8103-wdt.

If a device tree conforms to this schema by omitting the generic fallback,
does it cause a regression where the driver silently fails to bind?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505-apple-m3-i=
nitial-devicetrees-v2-0-b0c2f3519e0e@jannau.net?part=3D3
