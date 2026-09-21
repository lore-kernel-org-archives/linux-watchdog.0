Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145339734A;
	Mon, 21 Sep 2026 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010137; cv=none; b=tXASlSlBE0N/7tP59+B6aZ7r7yOoj2cJODujzwXc2nMS5xw5HU0NpfbFMzvbNAPuYs0GvpF86gun6ENPsXq9s5A2MNKzEkHEr7uxJ9T6yuyVyuGPZd3QBgsjDhjOcWji6ocuPQ1pK7d11wb79WJSw7D8g/KIXPZtgDgeVyzpeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010137; c=relaxed/simple;
	bh=8JT3Qgl0HCNtmwCyq2mvlnvxdhGIsrNUUx45txXCtHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz3XXAgJN4/Izq7GH5GzAaLIS2hBEnYVzyizxBkTLkyfUdZWWV4IEpB1pSOAEcM+hfztBxkuXonZ0elReRaKqxcEMG09yiuShqtChvJqKVSMX1kWldoD9U2qJTC7Z9jwBhJhXI/U0HSNqwN2UOhSt05RA6n/Zs8q/5pop2w9gsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsEMimN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsEMimN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA991F000FF;
	Mon, 21 Sep 2026 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790010135;
	bh=BNgzQJQScPoKdJ7NXfNKwN/QrHOdyClCEVMG1h6U6Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AsEMimN2DPXql9T67EgdRl4kCRW3sXR2+DctpxlAcE4IXBHGQcwkej99joBGss2/6
	 Vrtp/hhqjVrJsOtY20z+eHlTODUicsOXEOVFi9vNSwiumgxV957aT6upVchSmaa4mc
	 bAi4SdzNZpnZBzdzQFm6CjTSwczP6b3ksYaEK9LVloC6EtuohFFnVa8J1ELTWAEmHq
	 Mw/qMiWYiZkEtcoL53bvTSxPgezIUAgcHBsQJrMiTAiVXt6gJ91q4phhdtgl+YptUG
	 vEHfRovd2/ogSq67aXncjPpnrAgCb1cnfZdDN3Dr/99jfY32QVLk5kzFQ6ggaoUbxs
	 Lqjw+I+1DxnSg==
Date: Mon, 21 Sep 2026 12:02:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Radu Rendec <radu@rendec.net>,
	Janne Grunau <j@jannau.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@kernel.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: watchdog: apple,wdt: Add t8140
 compatible
Message-ID: <179001013341.898071.239546470879636582.robh@kernel.org>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
 <20260911-apple-a18-pro-initial-devicetrees-v2-5-08d06cf011d4@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-5-08d06cf011d4@cyberchaos.dev>


On Fri, 11 Sep 2026 18:58:42 +0200, Yureka Lilian wrote:
> The watchdog on the Apple t8140 (A18 Pro) SoC is compatible with the
> M1-M4 SoCs. Add "apple,t8140-wdt" as SoC specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

