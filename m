Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F04218B1;
	Tue, 11 Aug 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438479; cv=none; b=cWRB/EMJyXGbIYP3MYRrdXB6YLt8Mxb0d7C8TVy55lqrJK5XPTSxwXS8h4sPzHLx8bPMKqhk2rAdIBTR/gDQxqkobnr02EG04x2w2nFjIL/v7PQLPYjq2++oBEIFNsUtDQHTAI8XEMNI9e121L8/pMjTizZYUh+gT789pm+NFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438479; c=relaxed/simple;
	bh=LsV7c+j7Qgj8UgwIQK0RK07NxtiXQSuVXBHmqf6+fTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPQOONW8KDmqghGzXwEwl6dit/GiSbOvdzgkQ+PVYiPTJZ4V4NKQI9M05a9F14PCLc15RvTrsGFYzO1A6+Z3clFg2+HykB75iu5fwAAltmR0I6RGfvalxVINtHT/28sQkPnVTEBHMjqnpiAqq80nTZB8dkSXHKnQWcp/pTt/8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1zmzH0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1zmzH0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3C11F00A3A;
	Tue, 11 Aug 2026 08:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438478;
	bh=g37Y6fNgG/y+1/VPNRviqmmo3geO3qLh2eJAV1qSjyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n1zmzH0S2tsEexkCvIBORvYjJ6JifsmNIVBI7j7oYS/QpisL1VhYe7MKINDEHptDx
	 yVlzIhsE2A8P/vkLY4ikiQ5BN2JCc7HtmNFLM3m3SSylOEH3oxmiwTS1IJjZXjAcwO
	 u2uhQAB5ldqqYP5GdK9BjU9bx90svSjymMYfL95oTM5Zh1Ux+2K7a5m47/dvJYhAVG
	 3wv5kZXArN/6WB9QP2E0nZCeHErM6xm/D20s8o/oinCFc69Pe22jrwsAM8sz6w4kJJ
	 yZxn+Dm1QFt4eUWlc/AlcVo4MTywMug2qO461vh1we1glx6O9ni1QGQWFMBzTPg4ih
	 OzZTnvsEVYTuw==
Date: Tue, 11 Aug 2026 10:54:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/8] dt-bindings: reset: Add mt6589 toprgu reset IDs
Message-ID: <20260811-amethyst-seriema-of-gallantry-ca9c7f@quoll>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809160643.33991-2-l.scorcia@gmail.com>

On Sun, Aug 09, 2026 at 06:03:25PM +0200, Luca Leonardo Scorcia wrote:
> Currently mt6589 watchdog driver implements the watchdog feature, but

Driver is not really relevant here. If device does not have resets, why
would you add them?


> not the reset controller feature, which is actually supported by the
> hardware.

So binding already has reset-cells or not?

I already asked at v1 to clearly express why you are doing this. You
will get the same comments if you do not improve commits.

> 
> Add the bit definitions for the 12 mt6589 toprgu resets, which will be

We do not take bits, but identifiers of resets.

If these are bits, then not really a binding, so drop entire header.

> used in the following patch to enable the reset controller. Values
> determined from stock Android sources.

Nope, Android does not matter here. We do not add bindings for other,
unreviewed projects with poor quality and poor processes.

> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../reset/mediatek,mt6589-resets.h            | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h
> 
> diff --git a/include/dt-bindings/reset/mediatek,mt6589-resets.h b/include/dt-bindings/reset/mediatek,mt6589-resets.h
> new file mode 100644
> index 000000000000..ee08c39df513
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6589-resets.h

Filename must match compatible.

> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT6589
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT6589

Best regards,
Krzysztof

