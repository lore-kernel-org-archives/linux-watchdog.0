Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC131B833;
	Sun, 12 Jul 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783869983; cv=none; b=WtD5a/MvuCEMiF6sj28qYbGK0ROFC5MJyfgwoAGbn/wK88hB4AGpK0Kru5wL6xYADzL2TClJFxUZoS0a3Ei8+vyjzE0aEi0wCU4BDG9j1Okg7BJ8bZzoO+aHGuSHYR/iLZ0g19Qlnwal9OBQhRMy6CoDeUPgAwr7/oGE0I5Zgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783869983; c=relaxed/simple;
	bh=erqhuuhM2CApyYa7LUME/gFhzK+s5W9+ovCiDX7+4ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7NG+MRq7UUQmPmoquggvZZc0BJ1dz1f5us5EK7lyu78b7kKAFRQpLACYuxYBvgccFunryplwr20NAtf6rPSXgA4prOQi20ChXf92ndnxlV6o82u4UIu2nwjROPiOTKiVo3tVS5LWfw/EgJz9NpBOpbuClbNaxfQR0jziiWDwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1AN929U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1AN929U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7C81F000E9;
	Sun, 12 Jul 2026 15:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783869982;
	bh=x2V9TkUu02mZtF/pb/M+ixilm2tIOgotOavTOjYTCdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O1AN929U+LEOp44PdbRDXDwN/N+AhfZMW1rCySoCXZRYSQwjVrj53cfqq3Eg/qSt3
	 tQBWlfqdjDmAuAf7r5hZMPESFNDp+9xJRkRj171sOG818SuHhDIzveei/liHDJ4olz
	 cVg73H6KAI9eYsPGsq2hmOOYdcOXOu9oQy/k7bA27X+m7cgkm/wIm4nyS/J3TdTf1x
	 bMb5Dq2jkzurzq+rU4tes6/v2Ra9cp4hq06uowAPnx8DN6MRHimv5FxB8ttxxdAPId
	 sNFkJ/nxDdkruowawrz0tm2pwtAoSn/WRifX32TcJM5gSCfDgvnLHkIN5tCWby1SnW
	 gcFjGUZJ3HmwA==
Date: Sun, 12 Jul 2026 17:26:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Fabio Estevam <festevam@nabladev.com>, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Jamie Iles <jamie@jamieiles.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 08/12] dt-bindings: watchdog: snps,dw-wdt: Add RV1106
 compatible
Message-ID: <20260712-reasonable-unselfish-oyster-aea7a5@quoll>
References: <20260706195818.3906949-1-sjg@chromium.org>
 <20260706195818.3906949-9-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706195818.3906949-9-sjg@chromium.org>

On Mon, Jul 06, 2026 at 01:58:04PM -0600, Simon Glass wrote:
> Add the compatible for the watchdog of the Rockchip RV1106, which is
> compatible with the Synopsys DesignWare watchdog.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

