Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670348F03E;
	Thu, 10 Sep 2026 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047543; cv=none; b=ExzUC4pWWLfbj2qNnA8tvl/+SnTJ5zQsKK+bd5a8LDuzzJ1vclbU48XdtAHZT0z2/Fn3PyDLmZz50JETUAW1Oj9xNPgi9HgshvNdfH0bumFlLJ4Ln8Oe/inlhnEIDe5SfgfVxJQdpcLYDOz865tCdeamIEQiZve6Iz6tiAsEKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047543; c=relaxed/simple;
	bh=qNQbWhzkJJssUJVitD2nzb/OS5KtUH+QbWhYXxuUlV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmSo2/KZvpFr7/eonGKJ7soIqp1HXacu55u1Bf/VKOKvqzlcOBwlT4CLY83t/ct8rUGUXvPKqGHIDs7+wRuqWCkvgvI6sBIQJ+2L2ZJN9GmCFIOM0LYE22tl8t6G5XE4RH1dzhq5FY5ciqrm7jVuof1etd7Z2qBtIm1Z+1jUxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AVM5p1SV; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AVM5p1SV"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hgf0B2FPgzKnVM;
	Thu, 10 Sep 2026 15:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789047530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUX5+gLyZAnP+hET6uf/pLlFw8Zwibdi/KIZTVJajXU=;
	b=AVM5p1SVJTMybgY83sDrM8ghcdxBl9w7DmaxUYlPh5qWX7HHkdbzsQylsQRLzy0cOFPU9D
	+Bxff/k8aRv7Ddt0x0in+04pTa5VfvYDCoVn3EhR4+kB6a0ZEtIFNK8YCjbuYY3GCVuS3n
	yESj7lYVCqsYZ/mI2Sup5xhke19KMsez3MoRrNHaH6m6LRaaeF2EfEg8LqT1sPQXLhNgY5
	L6smBxrBrwnnSIpfNAHRa5cWybNrhb9S6bkh8KH+4lU7z9dzhvVkqvG0tn4UEBQen5953v
	tEYxajEOSWBdZF9rOTAMhbsHH6HTepUZl4s26b8y4ZDR1vp5K81HXruopDqxGw==
Date: Thu, 10 Sep 2026 15:38:43 +0200
From: Zakariya Hadrami <zkh@mailbox.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, zkh1@proton.me
Subject: Re: [PATCH v4 4/4] ARM: dts: mediatek: Add basic support for Amazon
 ford board
Message-ID: <aqKxMgAI4bPNx78kzjYD05-zkh@mailbox.org>
References: <20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org>
 <20260909-mt8127-amazon-ford-basic-v4-4-e9af5c420ab1@mailbox.org>
 <ab00e8c8-cbc2-4fe1-8900-f169aeab5a98@collabora.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab00e8c8-cbc2-4fe1-8900-f169aeab5a98@collabora.com>
X-MBO-RS-META: bxmk3mkmxrb34g5mrb17nipnddazm3fu
X-MBO-RS-ID: d3b653577f41815733c

On Thu, Sep 10, 2026 at 11:29:55AM +0200, AngeloGioacchino Del Regno wrote:
> >diff --git a/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
> >new file mode 100644
> >index 000000000000..8edad5482de2
> >--- /dev/null
> >+++ b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
> >@@ -0,0 +1,54 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+
> >+/dts-v1/;
> >+#include "mt8127.dtsi"
> >+
> >+/ {
> >+	model = "MediaTek MT8127 Amazon Ford";
> 
> Please be friendlier with whoever reads this model string :-)
> 
> 	model = "Amazon Fire 7 2015 (Ford)";
> 
> that's better, isn't it?

My bad, sorry!

This and the missing space in watchdog compatible fixed in v5.
Link to v5: https://patch.msgid.link/20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org

Thank you very much!

> 
> After applying the proposed change,
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Cheers,
> Angelo
> 
> >+	compatible = "amazon,ford", "mediatek,mt8127";
> >+	chassis-type = "tablet";

-- 
Best regards,
Zakariya
