Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B433932FA;
	Sun, 13 Sep 2026 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288554; cv=none; b=dpsNeKtBhsLhCf0ojyT9A7hFBxRjdbxdaGuwUB79LPhdpqw+J/oJu17Zojue5waP3RiEaPmMf9r2gKJTY3Xqac3LZ0XgDc9wjOoxOLO1THYngjJpBGDft99pGeyFCWeWmgt/GFAdg5ykT/lwMPeauf5AMCzLSRbHSgdSXw1kAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288554; c=relaxed/simple;
	bh=Tsx2Gco9uYaEpPHBrmaGMRtIBdFThUZw38vNMOQ07dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCp8m4Z+hZlwcA2feN4M9SJQ62SxOmoyxnIQ1wrP6yUsXLUo+iCXLCM55B98a8PALoJ/WLIQHAg5HE6GmxGG6rGavL65tkLKcLdbz/BVqoVD+KWVmtSwFwoALO12EytDiia5LhYjvEmrsk3+fjkKim8/RkOddGn7JpdpJVoc+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckfEgG1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckfEgG1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0221F000FF;
	Sun, 13 Sep 2026 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789288551;
	bh=MxVsQHt0PD/AoS3HnL1w++8paOmcsm0rJPQZ5P/iM5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ckfEgG1xnIugOq10gUjrGBEhKdAjNkT74xq0yXlikBeybfgW4fsyVnnbUUgrDOZIH
	 blAn+WgZtLEv1Z8wRd3aryKg/VBkGPqcFkQODhWZ7OcjlbT2Iprm964nzN6z4qEe1S
	 +oHALBd4HSAR+x1MakMiJy34qOrpHuHKItmssvhEIOxyDx2BgSZVI09bNjkGEgfwz8
	 x4Ckk29IeEAi1kPjEtpQE1t+NsPG7+uYBo5BX9YASSeEIPSsRqKdj4c+St5lPWD1Mb
	 mgN8ZClfWKWgAfoOuY0WV/Ghugdj4hy+fYE9d2feHNoHVBhddaBNuJ5rq8vEr23zqo
	 mRR5y9Wq8b3LQ==
Date: Sun, 13 Sep 2026 10:35:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/8] dt-bindings: watchdog: Add compatible for
 MediaTek mt8167
Message-ID: <20260913-octopus-of-incredible-gallantry-4ba15d@quoll>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
 <20260908174259.9009-4-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908174259.9009-4-l.scorcia@gmail.com>

On Tue, Sep 08, 2026 at 07:38:30PM +0200, Luca Leonardo Scorcia wrote:
> Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
> which in turn falls back on mt6589-wdt. However according to the data
> sheet mt8167 toprgu is not actually compatible with mt6589 (it has 14 sw
> resets instead of 12, and its reset bit map table is different from
> mt6589).
> 
> Update the mtk-wdt binding to add a dedicated compatible for mt8167 and
> add the IDs that can be used in device trees to identify subsystem resets.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/watchdog/mediatek,mtk-wdt.yaml   |  1 +
>  .../dt-bindings/reset/mediatek,mt8167-wdt.h   | 21 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt8167-wdt.h

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

