Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1339B4A1;
	Fri, 17 Jul 2026 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279785; cv=none; b=tpOv8W9KK0ikF0cNf9pwOCFjP6xHS6U16ofM7G+GPv2LiBhqBbnJL/Hgc3tx4N5bkc3KpJpWdOtC2Sp6QRhOfeUTbfoMBnwhMUzrkk1jIrD3uX9tZHBjbJNTZLFVl2BowI5hpCq5wmjKMAvIjujF63W7vkmJDXmkywbOgCvqBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279785; c=relaxed/simple;
	bh=oahcaibt+PjrNkWiO4X7R/Tb6Z6hbI/te0fo2j/4pFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsP31xmDDDDeSPOkCfm5xrJeXMyAZ0EuWVLx2XM+1jxujMdjto3uQ935LTX6L7n1FEQtb9OMLkfR/cZd9v3YAfUVbxyDQLS/BtK1y083Q8LmYaS2zfV4E4f8bcPbF5MX4wr7l2UJ3jXIkCsSNC41DDZD8i4zwydyJN9EnZy/kig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRtaN053; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRtaN053"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A4B1F00A3A;
	Fri, 17 Jul 2026 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279783;
	bh=Lxc4smYQ3yP6Fc8P815CCY/s/RuhTXwEKwVYPnAr0bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZRtaN053SigZymTfwMifByaVtj/ZW7uOX6Gc6gCUBr/fqYWJ7yRSRkaAehOyyXkb3
	 HfN9l8brnTD5zzWL3VlG8Lr+wh/HZIsbk1qeTKKnLL5/ooCstop+shFyATnq/pks7G
	 Nd7wvnbMk0piXNXNFJWZfWi9snM9bYEJZ9AJ7UuimoHhEmV/z3RjNZ2xHJTe/wlqjN
	 AK01pApq28KBu+Cg81DF3MdlS/4C0DI63+X+BHAVkgmGIhiM16yB3qrsmOHUPSv8V8
	 hsADYDEkuiNWApmW4Td2Vbah3Bn2w0QBJhKYPeElbWa0UUaYFK0oiC8hLMnMxFl8I4
	 mFTOv+PBguikw==
Date: Fri, 17 Jul 2026 11:16:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Roman Vivchar <rva333@protonmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: watchdog: mediatek,mtk-wdt: add
 compatibles for all SoCs
Message-ID: <20260717-miraculous-bull-of-prowess-be08b9@quoll>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-3-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716161923.266315-3-akkun11.open@gmail.com>

On Fri, Jul 17, 2026 at 01:19:18AM +0900, Akari Tsuyukusa wrote:
> The driver recognizes each SoC-specific compatible, update the binding
> to list them in the top-level enum alongside the existing ones. Keep
> the fallback items definition so that old DTS continue to validate.
> 
> Affected SoCs: mt2701, mt6572, mt6582, mt6797, mt7622, mt7623,
> mt7629, mt8173, mt8189, mt8365, mt8516.

I do not understand what and why you are doing. Just because driver
recognizes some compatible is not a reason to move compatibles around.

This completely lacks explanation (in terms of DTS, see writing
bindings).

Best regards,
Krzysztof

