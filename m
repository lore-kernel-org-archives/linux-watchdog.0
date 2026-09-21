Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16684E1C6F;
	Mon, 21 Sep 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010120; cv=none; b=Qzx7Lig1pZYidF54sma4QjRJ/Zl5y2KWbMXJmwCWmy3eZ/4ukiX5d95Mo6KVzs4pyKfv8EF6j/oABfyqPAQ5maxUYfSdGc8W4yy8FLuF3qHqTWezfoeVPp/kieM7ooBzw6srQ8GVp0G9uL5laVd1OdVqkT04kvG6icwRAThsRxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010120; c=relaxed/simple;
	bh=YbyAVvt5zAd2LwHhIdJI61gTc/XxiYLYy/UEuHHDhW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE/WyeI9a1Fmrg1Km+41Vb6sAxCN4YOwtXS8N+o7Xtl9y8GodFFB97CMjSOPtoAoSPw5R1ITjUlHpCezTd4pTZrpgbpgBwSqfrbQW4BflbI+QT3WH5MguIlYO+ZlVOW7TSXAFGk+gDBIMAEwI8kEBn+Ytdqg2WGjKKC6CS3vjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzYbCsu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzYbCsu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F84A1F000FF;
	Mon, 21 Sep 2026 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790010118;
	bh=bw+ZaWVSjn9aV8DWYMQu9wB62I8RjQbusfdMXEpi7XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KzYbCsu0P/Jt3i675Xbvb6phteMZPiWMHSGfuq+Wa2WbubZdeQaP6WikpBSW80u60
	 1pHIFNb/YEe5yPH/TEcrCaudmolpSRmhNYazNiE5XFpAyBJLBgpvSMXgcXEXe7dwdf
	 uXm3LNfTDQChIw+WsTc2WorlH+23r7qwkagfzQwS/baiRSFA4cHABrc1WkkRWu8nKf
	 zjtkSHUT9Pcyjc8/IPelCUbzHKv4mUsJSRpyNBSVQKcNnMDv244lhvZ4FAJfWIEQJP
	 SK9P7DAktY6mGZ1c/mVIO+2QFKBx3WCmsvi8GuMmkhdN1O6W5tyRVlF/QPYR/Uennp
	 Xak5XhuezCMrg==
Date: Mon, 21 Sep 2026 12:01:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Radu Rendec <radu@rendec.net>, Thomas Gleixner <tglx@kernel.org>,
	Janne Grunau <j@jannau.net>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/7] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
 t8140 compatible
Message-ID: <179001011606.897140.14733096729138294772.robh@kernel.org>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
 <20260911-apple-a18-pro-initial-devicetrees-v2-3-08d06cf011d4@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-3-08d06cf011d4@cyberchaos.dev>


On Fri, 11 Sep 2026 18:58:40 +0200, Yureka Lilian wrote:
> The device power state management of the PMGR blocks on the Apple
> silicon A18 Pro SoC (t8140) is compatible with the M1-M4 SoCs.
> Add "apple,t8140-pmgr-pwrstate" as A18 Pro specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

