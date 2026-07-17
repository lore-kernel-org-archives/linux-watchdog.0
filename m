Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AD39CCFF;
	Fri, 17 Jul 2026 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279848; cv=none; b=C/Cxd0krcABqkvN5Bh19jeEk/8EY/MJo6LZsM5b5IDlHKw8R8XDZfmrU1n8nYyrSHOIFMdcIFkcMGDmx5KpHMyj6ZQhz9rMQYrAeBSZYriCG780i9uee/3Za8xIkmUmz/WJF9GormyZkc5qXPglJwoFTbakfK61v+U2VkbXNuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279848; c=relaxed/simple;
	bh=WsqS/RENXKBaiPcJVoqlvqE5VI6ff8i4YR1XPG/1jws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5C/TGzpOeq5NoraSUkYNpLqhzPnzXLOupu1remMMAhfd8XS5luHYyUkT9nt4C2hO9uH9uVVIAJdfQmv/2/8FoA1ObYU7QxAtQ6vO7KMlR8fTphp83ioAACcMPjr5vywODGGLzK0KFSL+JPJI7VwGPuFUgCAiub449TB/gZMUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5HakIZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5HakIZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E19E1F000E9;
	Fri, 17 Jul 2026 09:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279847;
	bh=WsqS/RENXKBaiPcJVoqlvqE5VI6ff8i4YR1XPG/1jws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m5HakIZ0OPmQfxWfVzz83Zk5vj5X4xylgQw5lZEic4qN12nSEtvzPt1akW7R3aG7I
	 BIDW7MNUu9XuwovXeZfEVuowJb+pmjYjaBtAwb6s9qo80wJ+e4R+D7cwCFSF5d9nMy
	 4glZQ0q2Xh4igofwJdYWFu1MiHT4nfstnSwWd1LEG/TF4Tzz3fcMmA+wk4T0d1iR6s
	 +x4V4/DBH6xRzJ+GgJOGTDa6lXoghO6AmfINorr8Emj2Vp9lvZylRbetpr8HhUZBbS
	 1tdZuHf1ZiVX+winVpJrqY0bF8ICBaN4jPHiziMBfXJH7k1B2kXXTpEratoxQorgFG
	 8nHgLbNmzWVnA==
Date: Fri, 17 Jul 2026 11:17:23 +0200
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
Subject: Re: [PATCH 1/7] watchdog: mtk_wdt: add explicit compatibles for SoCs
 using mt6589 fallback
Message-ID: <20260717-unbeatable-strict-heron-fd1741@quoll>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-2-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716161923.266315-2-akkun11.open@gmail.com>

On Fri, Jul 17, 2026 at 01:19:17AM +0900, Akari Tsuyukusa wrote:
> Several SoCs currently rely on matching "mediatek,mt6589-wdt" via the
> fallback compatible. Add dedicated of_device_id entries for each of
> them so that the driver can match directly on the SoC-specific string.

This makes no sense, NAK.

Best regards,
Krzysztof

