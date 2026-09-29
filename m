Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8E497383;
	Tue, 29 Sep 2026 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671488; cv=none; b=YdfCqHWcMxW5m6Jxj0DacYEfiOf2KqnbIDNkoEvoEWfmD4cMUsIdxdtCr7wio92PzYtAggSZEMB+bWP2Cj8uCaXT83V2RD2nNXH8SRG+iMS/Qbh5NwL7k4ieF5BxbjYJjKZzgqWRoeC047ylOaPBafzrnhkURYBWgGlNuJyGR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671488; c=relaxed/simple;
	bh=KAWMLDlFlM0Q8LxOZIgWnBmOL9ihn4eLXQuQhVyXf+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzyyfkB0x+rHCSaOMl8WCXpP9+XB75kRzuCCQC4igAGVIzBECWVo8TxrRG/Uar92I9kioH92LeBR0wQuEMy42IgI812dx5YLcOPnHunplZzgmVI0XDrrHGmQtWHhGE1ktRoORy22kUc4SKWaAgzm9beYRT1TXHU5FRxO/hzoyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/lYIjMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/lYIjMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551FA1F0089A;
	Tue, 29 Sep 2026 08:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671479;
	bh=HGik1thLDIWu+rUs+0ZfZjo/C0bB3KuUWWNKGA0+Bxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m/lYIjMfw0C9EC3gduvBdvwV8OaknPDCHJaHAPcj7d+oyM1KFslpZLrgXPDQ3Py9F
	 q/h9BNzvB8I8FAWA4gb4IM6weh92WMcTixeibBeOLCjLnwREHCeODIY1ziXJY5s/Ee
	 OnsSC15sbrZ9BXYIC56KE7pLZO3N35AAlklq0HwQwVwk+T8TFGngTO9zmQzw8U7Dvb
	 m0qCJVaBCsMPOwde348kB7Sk866VTL4oukxYRxTBIPiXpR7ZoG6u+RWb1xip8fNqNs
	 86UJe0JqfckjTPXhV/dcrDfUzbdjD2aBnyFVKZvksjWAMCkOOYf21e6FR7c9txy4go
	 aX4Ls8qvhIkyA==
Date: Tue, 29 Sep 2026 10:44:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chuanhong Guo <gch981213@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: mediatek: add MT7629 TOPRGU
 reset indices
Message-ID: <20260929-spiffy-harrier-of-snow-b78e7b@quoll>
References: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
 <20260926-b4-mt7629-toprgu-v1-1-c124bf9ac273@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926-b4-mt7629-toprgu-v1-1-c124bf9ac273@gmail.com>

On Sat, Sep 26, 2026 at 07:13:59PM +0800, Chuanhong Guo wrote:
> Define all seven reset IDs documented in the MT7629 TOPRGU SWSYSRST
> register: INFRA, ETHDMA, DDRPHY, INFRA_AO, CONN, APMIXED and CONN_MCU.
> Use their register bit positions as reset IDs.

If so, I say you don't need bindings then... but fine except:

> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  include/dt-bindings/reset/mt7629-resets.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt7629-resets.h b/include/dt-bindings/reset/mt7629-resets.h
> index 6bb85734f68d..828919eee298 100644
> --- a/include/dt-bindings/reset/mt7629-resets.h
> +++ b/include/dt-bindings/reset/mt7629-resets.h
> @@ -53,6 +53,15 @@
>  #define MT7629_PCIE0_USER_RST			30
>  #define MT7629_PCIE0_PIPE_RST			31
>  
> +/* TOPRGU resets */

Didn't new bindings switch to continues indexes?

> +#define MT7629_TOPRGU_INFRA_SW_RST		0
> +#define MT7629_TOPRGU_ETHDMA_SW_RST		1
> +#define MT7629_TOPRGU_DDRPHY_SW_RST		6
> +#define MT7629_TOPRGU_INFRA_AO_SW_RST		8

Best regards,
Krzysztof

